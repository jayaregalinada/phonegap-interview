###
app_factory_question
###
interview.factory 'Question', ->

    uploader = 'http://i.ubl.ph/upload.php'

    questions = [
        {
            name: 'What is your name?'
            response: [
                'Nice name you got',
                'Great name',
                'Cool name',
                'What a great name'
            ]
        }
        {
            name: 'What is your age?'
            response: [
                'Looking young, huh?',
                'Age doesn\'t really matter',
                'Really?'
            ]
        }
        {
            name: 'Do you have your 2 eyes?'
            response: [
                'You can see things very clearly',
                'I hope it is properly working'
            ]
        }
        {
            name: 'Do you have a facebook account?'
            response: [
                'I think I do not have any',
                'I really need to create one',
                'No way!'
            ]
        }
        {
            name: 'Do you have skype?'
            response: [
                'Oh c\'mon'
            ]
        }
    ]

    getFileUploadOptions = (fileURI)->
        options = new FileUploadOptions()
        options.fileName = fileURI.substr( fileURI.lastIndexOf('/') + 1 )
        options.mimeType = "audio/mp3"
        options

    uploading = 
        success: (e)->
            console.log( 'uploading success' )
            console.log( e )
            return
        error: (e)->
            console.log( 'uploading error' )
            console.log( e )
            return

    {
        all: ->
            questions
        get: ( questionId )->
            questions[ questionId ]
        upload: ( file, onSuccess, onError )->
            options = new FileUploadOptions()
            ft = new FileTransfer()
            options.fileName = file.substr( file.lastIndexOf('/') + 1 )
            options.mimeType = 'audio/mp3'
            options.fileKey  = 'photo'

            ft.upload( file, encodeURI(uploader), onSuccess, onError, options)

            
    }