  /**
  ******************************************************************************
  * @file             ColorHelpers.js
  * @brief            Color Helpers(ECMA-262 5 edition with Qt 5.5.1)
  * @authors          Nik A. Vzdornov
  * @date             10.09.19
  * @copyright
  *
  * Copyright (c) 2019 VzdornovNA88
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
  * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  * copies of the Software, and to permit persons to whom the Software is
  * furnished to do so, subject to the following conditions:
  *
  * The above copyright notice and this permission notice shall be included in all
  * copies or substantial portions of the Software.
  *
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
  ******************************************************************************
  */
  
.pragma library


function convert ( color ) {

    var strColor = color.toString();

    var _ = {
        toARGB : function() {
            var res = null;
//console.error("convert ---> toARGB ---> ",color,strColor)
            if( color !== undefined && color !== null && strColor.indexOf("#", 0) === 0 ) {

                res = [];

                strColor = strColor.slice(1, strColor.length+1);
                if( strColor.length === 6 ) {
                    strColor = "ff" + strColor;
                }

                for( var i = 0,start = 0,end = 2,offset = 2; end <= strColor.length; start += offset, end += offset, i++ ) {
                    res[i] = parseInt( strColor.slice(start, end),16 );
                }
            }
            else if(strColor.indexOf("#", 0) !== 0 ) {
//                console.log("Invalid color format - ",strColor);
                res = null;
            }

            return res;
        }
    };

    return _;
}

function luminance ( color ) {
    // Formula: http://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef

    var lum = 0;
    var argb = convert(color).toARGB();
    var rgb = [];

    if( argb !== null ) {

        var alpha = argb[0]/255;
        var base  = (argb[1] === 255 && argb[2] === 255 && argb[3] === 255) ? 0 : 255;

        for(var i=1; i<4; i++) {

            rgb[i-1] = alpha*argb[i] + (1-alpha)*base;

            var value = rgb[i-1];

            value /= 255;

            value = value < .03928 ? value / 12.92 : Math.pow((value + .055) / 1.055, 2.4);

            rgb[i-1] = value;
        }

        lum =  .2126 * rgb[0] + .7152 * rgb[1] + 0.0722 * rgb[2];
    }
    return lum;
}

function contrast ( color1,color2 ) {

    // Formula: http://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef

    var ratio = 0;

    var argb1 = convert(color1).toARGB();
    var argb2 = convert(color2).toARGB();

    if( argb1[0] === 0 || argb2[0] === 0 ) return ratio;

    var l1 = luminance( color1 ) + .05,
        l2 = luminance( color2 ) + .05;

    ratio = l1/l2;

    if (l2 > l1) {
        ratio = 1 / ratio;
    }
//console.log("contrast - ",color1,color2,ratio);
    return ratio;
}

function getColorsFrom ( obj ) {

    var res = [];

    function isColor (item,index,array) {

        var propertyName = item.toString();
        var isPropertyHandler = propertyName.indexOf("Changed") === -1;

        return  isPropertyHandler                     &&
                propertyName !== "objectName"         &&
                propertyName !== "objectNameChanged"  &&
                propertyName !== "id"                 &&
                propertyName !== "ref";
    };

//    function isValidColor (item,index,array) {

//        var strColor = (array[item]).toString();
//        if(strColor.indexOf("#", 0) !== 0 ) {
//            console.log("Invalid color format from getColorsFrom( obj ) - ",array[item]);
//            return true;
//        }
//        else
//            return false;
//    }


    function object2color (item,index,array) {
        return { itemColor : { name : item , color : obj[item] } };
    }

    function array2color (item,index,array) {

        return { itemColor : { name : item , color : item } };
    }

    if( !Array.isArray( obj ) )
        res = Object.keys    ( obj          )
                    .filter  ( isColor      )
//                    .filter  ( isValidColor )
                    .map     ( object2color );
    else
        res = obj.map( array2color );

    return res;
}

function suitableFor( color,preferedContrast ) {

    if( preferedContrast === undefined || preferedContrast === null )
        preferedContrast = 0.0;

    var _ = {
        in : function( obj ) {

            var res = null;
            var colorSet = getColorsFrom( obj );

            function isSuitable (item,index,array) {
                return item.itemColor.contrast >= preferedContrast;
            }

            function toContrastColors (item,index,array) {

                item.itemColor.contrast = contrast(color,item.itemColor.color);
                return item;
            }

            function compareContrastColors(color1, color2) {

              if (color1.itemColor.contrast >   color2.itemColor.contrast) return -1;
              if (color1.itemColor.contrast === color2.itemColor.contrast) return  0;
              if (color1.itemColor.contrast <   color2.itemColor.contrast) return  1;
            }


            if( Array.isArray( colorSet ) && colorSet.length > 0 ) {

                res = colorSet.map   ( toContrastColors      )
                              .filter( isSuitable            )
                              .sort  ( compareContrastColors );

                if( res.length === 0 )
                    res = null;
            }

            return res;
        }
    }
    return _;
}

function match ( color1,color2 ) {

    return suitableFor(color1).in([color2]);
}

function inverseFor( color ) {

    return convert( color )
               .toARGB()
               .map(function(item, index, array){

                   var color_ = "ff";

                   if( !(index === 0 && item === 255) )
                       color_ = (255 - item).toString(16);

                   if( color_ === "0" ) color_ = "00";

                   return color_;
               })
               .reduce( function (color, item, index, array) {

                   return color + item;
               },"#" );
}

function inverseAlphaFor( color ) {

    return convert( color )
               .toARGB()
               .map(function(item, index, array){

                   if( index === 0 )
                       return (255 - item).toString(16);
                   else
                       return item.toString(16);
               })
               .reduce( function (color, item, index, array) {

                   return color + item;
               },"#" );
}

function addAlpha( alpha,color ) {

    var color_ = convert( color )
                   .toARGB()
                   .map(function(item, index, array){

                       var color_ = item;
                       if( index === 0 )
                           color_ = (Math.round(item*alpha));

//                       console.log("function addAlpha( alpha,color ) map - ",index,item,color_.toString(16))

                       return color_.toString(16);
                   })
                   .reduce( function (color, item, index, array) {

                       return color + item;
                   },"#" );

//    console.log("function addAlpha( alpha,color ) - ",color_)

    return color_
}

function isAlphaAdded(color) {
    var alpha = convert( color ).toARGB()[0];
    return alpha !== 255;
}
