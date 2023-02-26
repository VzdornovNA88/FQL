  /**
  ******************************************************************************
  * @file             Styles.qml
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

pragma Singleton

import QtQuick 2.0
import "../Core/Meta/"

Class {

    readonly property UnitMeasurement percent              : UnitMeasurement { readonly property string name : "%"       }

    readonly property UnitMeasurement m                    : UnitMeasurement { readonly property string name : "м"       }
    readonly property UnitMeasurement km                   : UnitMeasurement { readonly property string name : "км"      }
    readonly property UnitMeasurement cm                   : UnitMeasurement { readonly property string name : "см"      }
    readonly property UnitMeasurement mm                   : UnitMeasurement { readonly property string name : "мм"      }
    readonly property UnitMeasurement ft                   : UnitMeasurement { readonly property string name : "фут"     }
    readonly property UnitMeasurement mile                 : UnitMeasurement { readonly property string name : "миля"    }

    readonly property UnitMeasurement m2                   : UnitMeasurement { readonly property string name : "м²"      }
    readonly property UnitMeasurement dm2                  : UnitMeasurement { readonly property string name : "дм²"     }
    readonly property UnitMeasurement ha                   : UnitMeasurement { readonly property string name : "Га"      }
    readonly property UnitMeasurement km2                  : UnitMeasurement { readonly property string name : "км²"     }
    readonly property UnitMeasurement acre                 : UnitMeasurement { readonly property string name : "акр"     }
    readonly property UnitMeasurement ft2                  : UnitMeasurement { readonly property string name : "фут²"    }
    readonly property UnitMeasurement mile2                : UnitMeasurement { readonly property string name : "миль²"   }

    readonly property UnitMeasurement m3                   : UnitMeasurement { readonly property string name : "м³"      }
    readonly property UnitMeasurement cm3                  : UnitMeasurement { readonly property string name : "см³"     }
    readonly property UnitMeasurement l                    : UnitMeasurement { readonly property string name : "л"       }
    readonly property UnitMeasurement gallon_eu            : UnitMeasurement { readonly property string name : "гал"     }
    readonly property UnitMeasurement gallon_us            : UnitMeasurement { readonly property string name : "гал"     }

    readonly property UnitMeasurement g                    : UnitMeasurement { readonly property string name : "г"       }
    readonly property UnitMeasurement kg                   : UnitMeasurement { readonly property string name : "кг"      }
    readonly property UnitMeasurement t                    : UnitMeasurement { readonly property string name : "т"       }
    readonly property UnitMeasurement lb                   : UnitMeasurement { readonly property string name : "фунт"    }

    readonly property UnitMeasurement bar                  : UnitMeasurement { readonly property string name : "Бар"     }
    readonly property UnitMeasurement psi                  : UnitMeasurement { readonly property string name : "psi"     }
    readonly property UnitMeasurement pa                   : UnitMeasurement { readonly property string name : "Па"      }

    readonly property UnitMeasurement ms                   : UnitMeasurement { readonly property string name : "мс"      }
    readonly property UnitMeasurement sec                  : UnitMeasurement { readonly property string name : "с"       }
    readonly property UnitMeasurement minute               : UnitMeasurement { readonly property string name : "мин"     }
    readonly property UnitMeasurement hour                 : UnitMeasurement { readonly property string name : "час"     }
    readonly property UnitMeasurement day                  : UnitMeasurement { readonly property string name : "день"    }
    readonly property UnitMeasurement week                 : UnitMeasurement { readonly property string name : "неделя"  }

    readonly property UnitMeasurement m_per_s              : UnitMeasurement { readonly property string name : "м/с"     }
    readonly property UnitMeasurement km_per_h             : UnitMeasurement { readonly property string name : "км/ч"    }
    readonly property UnitMeasurement mile_per_h           : UnitMeasurement { readonly property string name : "миль/ч"  }

    readonly property UnitMeasurement hz                   : UnitMeasurement { readonly property string name : "Гц"      }
    readonly property UnitMeasurement kHz                  : UnitMeasurement { readonly property string name : "кГц"     }
    readonly property UnitMeasurement megaHz               : UnitMeasurement { readonly property string name : "МГц"     }
    readonly property UnitMeasurement rpm                  : UnitMeasurement { readonly property string name : "об/мин"  }

    readonly property UnitMeasurement celsius              : UnitMeasurement { readonly property string name : "°C"      }
    readonly property UnitMeasurement fahrenheit           : UnitMeasurement { readonly property string name : "°F"      }

    readonly property UnitMeasurement amp                  : UnitMeasurement { readonly property string name : "А"       }
    readonly property UnitMeasurement mA                   : UnitMeasurement { readonly property string name : "мА"      }
    readonly property UnitMeasurement volt                 : UnitMeasurement { readonly property string name : "В"       }
    readonly property UnitMeasurement mV                   : UnitMeasurement { readonly property string name : "мВ"      }

    readonly property UnitMeasurement l_h                  : UnitMeasurement { readonly property string name : "л/ч"     }
    readonly property UnitMeasurement gallon_eu_h          : UnitMeasurement { readonly property string name : "гал/ч"   }
    readonly property UnitMeasurement gallon_us_h          : UnitMeasurement { readonly property string name : "гал/ч"   }
    readonly property UnitMeasurement l_ha                 : UnitMeasurement { readonly property string name : "л/Га"    }
    readonly property UnitMeasurement gallon_eu_ha         : UnitMeasurement { readonly property string name : "гал/Га"  }
    readonly property UnitMeasurement gallon_us_ha         : UnitMeasurement { readonly property string name : "гал/Га"  }
    readonly property UnitMeasurement l_acre               : UnitMeasurement { readonly property string name : "л/акр"   }
    readonly property UnitMeasurement gallon_eu_acre       : UnitMeasurement { readonly property string name : "гал/акр" }
    readonly property UnitMeasurement gallon_us_acre       : UnitMeasurement { readonly property string name : "гал/акр" }
}
