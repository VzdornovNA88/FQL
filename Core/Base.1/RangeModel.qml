/**
  ******************************************************************************
  * @file             Navigator.qml
  * @brief            The set of constants of styles(name)
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

import QtQuick 2.2
import FQL.Core.Meta 1.0

Class {
    id: renageModel

    property real value : 0.0
    property real minimumValue : 0.0
    property real maximumValue : 99.0
    property real stepSize : 0.0
    property real position : 0.0
    property real positionAtMinimum : 0.0
    property real positionAtMaximum : 0.0
    property bool inverted : d.inverted

    onInvertedChanged: setValue( value )
    onMaximumValueChanged: setValue( value )
    onMinimumValueChanged: setValue( value )
//    onPositionAtMaximumChanged: setValue( value )
//    onPositionAtMinimumChanged: setValue( value )
    onStepSizeChanged: setValue( value )


    Private {
        id: d

        property real posatmin : renageModel.positionAtMinimum
        property real posatmax : renageModel.positionAtMaximum

        property real minimum  : renageModel.minimumValue
        property real maximum  : renageModel.maximumValue
        property real stepSize : renageModel.stepSize
        property real pos      : 0.0
        property real value    : 0.0

        property bool inverted : renageModel.inverted

        function qFuzzyCompare(p1, p2)
        {
            return (Math.abs(p1 - p2) * 100000.0 <= Math.min(Math.abs(p1), Math.abs(p2)));
        }

        function effectivePosAtMin() {
            return inverted ? posatmax : posatmin;
        }

        function effectivePosAtMax() {
            return inverted ? posatmin : posatmax;
        }

        function equivalentPosition(value) {

            var valueRange = maximum - minimum;
            if (valueRange == 0)
                return effectivePosAtMin();

            var scale = (effectivePosAtMax() - effectivePosAtMin()) / valueRange;
            return (value - minimum) * scale + effectivePosAtMin();
        }

        function equivalentValue(pos) {

            var posRange = effectivePosAtMax() - effectivePosAtMin();
            if (posRange == 0)
                return minimum;

            var scale = (maximum - minimum) / posRange;
            return (pos - effectivePosAtMin()) * scale + minimum;
        }

        function publicPosition(position) {

            var min = effectivePosAtMin();
            var max = effectivePosAtMax();
            var valueRange = maximum - minimum;
            var positionValueRatio = valueRange ? (max - min) / valueRange : 0;
            var positionStep = stepSize * positionValueRatio;

            if (positionStep == 0)
                return (min < max) ? Math.max(min, Math.min(position, max)) :
                                     Math.max(max, Math.min(position, min));

            var stepSizeMultiplier = Math.floor((position - min) / positionStep);

            if (stepSizeMultiplier < 0)
                return min;

            var leftEdge = ((stepSizeMultiplier)  * positionStep) + min;
            var rightEdge = ((stepSizeMultiplier + 1) * positionStep) + min;

            if (min < max) {
                leftEdge = Math.min(leftEdge, max);
                rightEdge = Math.min(rightEdge, max);
            } else {
                leftEdge = Math.max(leftEdge, max);
                rightEdge = Math.max(rightEdge, max);
            }

            if (Math.abs(leftEdge - position) <= Math.abs(rightEdge - position))
                return leftEdge;
            return rightEdge;
        }

        function publicValue(value) {


            if (stepSize == 0)
                return Math.max(minimum, Math.min(value, maximum));

            var stepSizeMultiplier = Math.floor((value - minimum) / stepSize);

            if (stepSizeMultiplier < 0)
                return minimum;

            var leftEdge = Math.min(maximum, ((stepSizeMultiplier) * stepSize) + minimum);
            var rightEdge = Math.min(maximum, ((stepSizeMultiplier + 1) * stepSize) + minimum);
            var middle = (leftEdge + rightEdge) / 2;

            return (value <= middle) ? leftEdge : rightEdge;
        }

        function emitValueAndPositionIfChanged(oldValue,oldPosition,is) {

            var newValue = d.publicValue(d.value);
            var newPosition = d.publicPosition(d.pos);

            if (!qFuzzyCompare(newPosition, oldPosition)) {
                renageModel.position = newPosition;
            }

            if (!qFuzzyCompare(newValue, oldValue)) {
                renageModel.value = newValue;
            }

        }
    }


//    function setPositionRange(min,max)
//    {
//        var emitPosAtMinChanged = !d.qFuzzyCompare(min, d.posatmin);
//        var emitPosAtMaxChanged = !d.qFuzzyCompare(max, d.posatmax);

//        if (!(emitPosAtMinChanged || emitPosAtMaxChanged))
//            return;

//        var oldPosition = d.publicPosition(d.pos);
//        d.posatmin = min;
//        d.posatmax = max;

//        d.pos = d.equivalentPosition(d.value);

//        if (emitPosAtMinChanged)
//            positionAtMinimum = d.posatmin;
//        if (emitPosAtMaxChanged)
//            positionAtMaximum = d.posatmax;

//        d.emitValueAndPositionIfChanged(d.publicValue(d.value), oldPosition);
//    }

//    function setRange(min,max)
//    {
//        var emitMinimumChanged = !d.qFuzzyCompare(min, d.minimum);
//        var emitMaximumChanged = !d.qFuzzyCompare(max, d.maximum);

//        if (!(emitMinimumChanged || emitMaximumChanged))
//            return;

//        var oldValue = d.publicValue(d.value);
//        var oldPosition = d.publicPosition(d.pos);

//        d.minimum = min;
//        d.maximum = Math.max(min, max);

//        d.pos = d.equivalentPosition(d.value);

//        if (emitMinimumChanged)
//            minimumValue = d.minimum;
//        if (emitMaximumChanged)
//            maximumValue = d.maximum;

//        d.emitValueAndPositionIfChanged(oldValue, oldPosition);
//    }

//    function setMinimum(min)
//    {
//        setRange(min, d.maximum);
//    }

//    function setMaximum(max)
//    {
//        setRange(Math.min(d.minimum, max), max);
//    }

//    function setStepSize(stepSize)
//    {
//        stepSize = Math.max(0.0, stepSize);
//        if (d.qFuzzyCompare(stepSize, d.stepSize))
//            return;

//        var oldValue = d.publicValue(d.value);
//        var oldPosition = d.publicPosition(d.pos);
//        d.stepSize = stepSize;

//        renageModel.stepSize = d.stepSize;
//        d.emitValueAndPositionIfChanged(oldValue, oldPosition);
//    }

    function positionForValue(value)
    {
        var unconstrainedPosition = d.equivalentPosition(value);
        return d.publicPosition(unconstrainedPosition);
    }

    function setPosition(newPosition)
    {
        if (d.qFuzzyCompare(newPosition, d.pos) || !d.maximum || !d.stepSize || !d.posatmax)
            return;

        var oldPosition = d.publicPosition(d.pos);
        var oldValue = d.publicValue(d.value);

        d.pos = newPosition;
        d.value = d.equivalentValue(d.pos);
        d.emitValueAndPositionIfChanged(oldValue, oldPosition,false);
    }

//    function setPositionAtMinimum(min)
//    {
//        setPositionRange(min, d.posatmax);
//    }

//    function setPositionAtMaximum(max)
//    {
//        setPositionRange(d.posatmin, max);
//    }

    function valueForPosition(position)
    {
        var unconstrainedValue = d.equivalentValue(position);
        return d.publicValue(unconstrainedValue);
    }

    function setValue(newValue)
    {
        if (d.qFuzzyCompare(newValue, d.value) || !d.maximum || !d.stepSize || !d.posatmax) {
            renageModel.value = newValue;
            return;
        }
        var oldValue = d.publicValue(d.value);
        var oldPosition = d.publicPosition(d.pos);

        d.value = newValue;
        d.pos = d.equivalentPosition(d.value);
        d.emitValueAndPositionIfChanged(oldValue, oldPosition,true);
    }

//    function setInverted(inverted)
//    {
//        if (inverted === d.inverted)
//            return;

//        d.inverted = inverted;
//        renageModel.inverted = d.inverted;

//        setPosition(d.equivalentPosition(d.value));
//    }

//    function toMinimum()
//    {
//        setValue(d.minimum);
//    }

//    function toMaximum()
//    {
//        setValue(d.maximum);
//    }

    function increaseSingleStep()
    {
        if (d.qFuzzyIsNull(d.stepSize))
            setValue(d.publicValue(d.value) + (d.maximum - d.minimum)/10.0);
        else
            setValue(d.publicValue(d.value) + d.stepSize);
    }

    function decreaseSingleStep()
    {
        if (d.qFuzzyIsNull(d.stepSize))
            setValue(d.publicValue(d.value) - (d.maximum - d.minimum)/10.0);
        else
            setValue(d.publicValue(d.value) - d.stepSize);
    }
}

