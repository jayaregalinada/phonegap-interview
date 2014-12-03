###
app_factory_question
###
interview.factory 'Question', ->

    questions = [
        {
            name: 'What is your name?'
            response: [
                'Nice name you got'
            ]
        }
        {
            name: 'What is your age?'
            response: [
                'Nice Age'
            ]
        }
        {
            name: 'Do you have your 2 eyes?'
            response: [
                'You can see things very clearly'
            ]
        }
        {
            name: 'Do you have facebook account?'
            response: [
                'I think I do not have any'
            ]
        }
        {
            name: 'Do you have skype?'
            response: [
                'Oh com\'on'
            ]
        }
    ]

    {
        all: ->
            questions
        get: ( questionId )->
            questions[ questionId ]
    }