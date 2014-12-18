#
#* Copyright (c) 2014, Intel Corporation. All rights reserved.
#* File revision: 26 February 2012
#* Please see http://software.intel.com/html5/license/samples 
#* and the included README.md file for license terms and conditions.
#

# detect useragent
ua = navigator.userAgent.toLowerCase()

# detect device
phoneCheck =
  ios: ua.match(/(iphone|ipod|ipad)/i)
  blackberry: ua.match(/blackberry/i)
  android: ua.match(/android/i)
  windowsphone: ua.match(/windows phone/i)


# detect browser
browserCheck =
  chrome: ua.match(/chrome/i)
  ie: ua.match(/msie/i)
  firefox: ua.match(/firefox/i)
  safari: ua.match(/safari/i) #this one is the same as chrome.
  opera: ua.match(/opera/i)

