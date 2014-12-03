###
app_directive_typewrite
###
interview.directive "typewrite", [
  "$timeout"
  ($timeout) ->
    linkFunction = (scope, iElement, iAttrs) ->
      updateIt = (element, i, text) ->
        if i <= text.length
          element.html text.substring(0, i) + cursor
          i++
          timer = $timeout(->
            updateIt iElement, i, text
            return
          , typeDelay)
          return
        else
          if blinkCursor
            if blinkDelay
              auxStyle = "-webkit-animation:blink-it steps(1) " + blinkDelay + " infinite;-moz-animation:blink-it steps(1) " + blinkDelay + " infinite " + "-ms-animation:blink-it steps(1) " + blinkDelay + " infinite;-o-animation:blink-it steps(1) " + blinkDelay + " infinite; " + "animation:blink-it steps(1) " + blinkDelay + " infinite;"
              element.html text.substring(0, i) + "<span class=\"blink\" style=\"" + auxStyle + "\">" + cursor + "</span>"
            else
              element.html text.substring(0, i) + "<span class=\"blink\">" + cursor + "</span>"
          else
            element.html text.substring(0, i)
        return
      getTypeDelay = (delay) ->
        (if delay.charAt(delay.length - 1) is "s" then parseInt(delay.substring(0, delay.length - 1), 10) * 1000 else +delay)  if typeof delay is "string"
      getAnimationDelay = (delay) ->
        (if delay.charAt(delay.length - 1) is "s" then delay else parseInt(delay.substring(0, delay.length - 1), 10) / 1000)  if typeof delay is "string"
      timer = null
      initialDelay = (if iAttrs.initialDelay then getTypeDelay(iAttrs.initialDelay) else 200)
      typeDelay = (if iAttrs.typeDelay then getTypeDelay(iAttrs.typeDelay) else 200)
      blinkDelay = (if iAttrs.blinkDelay then getAnimationDelay(iAttrs.blinkDelay) else false)
      cursor = (if iAttrs.cursor then iAttrs.cursor else "|")
      blinkCursor = (if iAttrs.blinkCursor then iAttrs.blinkCursor is "true" else true)
      auxStyle = undefined
      if iAttrs.text
        timer = $timeout(->
          updateIt iElement, 0, iAttrs.text
          return
        , initialDelay)
      scope.$on "$destroy", ->
        $timeout.cancel timer  if timer
        return

      return
    return (
      restrict: "A"
      link: linkFunction
      scope: false
    )
]