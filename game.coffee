###
# Basic idea of the game, iterate from a to z, ask user to put
# unix commands starting with the letter; the more cmd, the more
# score; 3 seconds per letter
###

# Configs
CMD_SCORE = 100
LETTER_TIME = 5
MAX_SCORE = CMD_SCORE * 1299

# UI
startBtn = document.getElementById 'startBtn'
inputBox = document.getElementById 'inputBox'
timer = document.getElementById 'timer'
score = document.getElementById 'score'
instruction = document.getElementById 'instruction'

# Stat
_score = 0
_currentLetter = 0
_timerInterval = null
_timerTimeout = null

FinishGame = () ->
    rank = _score / CMD_SCORE * 25
    rank = parseInt rank * 10
    instruction.innerHTML = "You score is #{_score}. #{window.ranking[rank]}"
    inputBox.setAttribute "class", "hide"
    score.setAttribute "class", "hide"
    timer.setAttribute "class", "hide"
    
ValidationCheck = () ->
    debugger
    inputs = inputBox.value.split ","
    for input, ind in inputs
        if window.allCmd[input]
            _score += CMD_SCORE
    inputBox.value = ""

SetTimer = () ->
    localTime = LETTER_TIME
    _timerInterval = setInterval(
        (e) ->
            localTime -= 1
            timer.innerHTML = "Time Left #{localTime}s"
        ,1000)

    _timerTimeout = setTimeout(
        (e) ->
            instruction.text = "Time up"
            clearInterval _timerInterval
            MoveToNextLetter()
        , LETTER_TIME * 1000)

MoveToNextLetter = () ->
    ValidationCheck()

    if _currentLetter >= window.aToZ.length
        FinishGame()
        return

    timer.innerHTML = "Time Left #{LETTER_TIME}s"
    score.innerHTML = "Score #{_score}"
    instruction.innerHTML = window.aToZ[_currentLetter]
    instruction.setAttribute "class", "center"
    SetTimer()

    _currentLetter += 1

StartGame = () ->
    _SCORE = 0
    startBtn.setAttribute "class", "hide"
    inputBox.setAttribute "class", ""

    inputBox.addEventListener "keydown", (e) ->
        if e.keyCode == 13
            clearTimeout _timerTimeout
            MoveToNextLetter()

    MoveToNextLetter()

startBtn.addEventListener "click",
    (e) ->
        StartGame()
