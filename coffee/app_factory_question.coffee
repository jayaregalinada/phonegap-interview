###
app_factory_question
###
interview.factory 'Question', ($rootScope, $upload, $http)->

    uploader = 'http://laravel.interview.local/uploader'

    questions = [
        {
            name: 'Question #1?'
            response: [
                'Response to #1 A'
                'Response to #1 B'
                'Response to #1 C'
                'Response to #1 D'
            ]
        }
        {
            name: 'Question #2?'
            response: [
                'Response to #2 A'
                'Response to #2 B'
                'Response to #2 C'
                'Response to #2 D'
            ]
        }
        # {
        #     name: 'Question #3?'
        #     response: [
        #         'Response to #3 A',
        #         'Response to #3 B',
        #         'Response to #3 C',
        #         'Response to #3 D'
        #     ]
        # }
        # {
        #     name: 'Question #4?'
        #     response: [
        #         'Response to #4 A',
        #         'Response to #4 B',
        #         'Response to #4 C',
        #         'Response to #4 D'
        #     ]
        # }
        # {
        #     name: 'Question #5?'
        #     response: [
        #         'Response to #5 A',
        #         'Response to #5 B',
        #         'Response to #5 C',
        #         'Response to #5 D'
        #     ]
        # }
        # {
        #     name: 'Question #6?'
        #     response: [
        #         'Response to #6 A',
        #         'Response to #6 B',
        #         'Response to #6 C',
        #         'Response to #6 D'
        #     ]
        # }
        # {
        #     name: 'Question #7?'
        #     response: [
        #         'Response to #7 A',
        #         'Response to #7 B',
        #         'Response to #7 C',
        #         'Response to #7 D'
        #     ]
        # }
        # {
        #     name: 'Question #8?'
        #     response: [
        #         'Response to #8 A',
        #         'Response to #8 B',
        #         'Response to #8 C',
        #         'Response to #8 D'
        #     ]
        # }
        # {
        #     name: 'Question #9?'
        #     response: [
        #         'Response to #9 A',
        #         'Response to #9 B',
        #         'Response to #9 C',
        #         'Response to #9 D'
        #     ]
        # }
        # {
        #     name: 'Question #10?'
        #     response: [
        #         'Response to #10 A',
        #         'Response to #10 B',
        #         'Response to #10 C',
        #         'Response to #10 D'
        #     ]
        # }
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

    uploadRecord = (data, fileName, onSuccess, onError) ->

        $upload.upload
            url: 'uploader'
            data:
                record: data
                name: fileName
            file: data
        .success (data) ->
            onSuccess data
        .error (data) ->
            onError data


        return

    {
        all: ->
            questions
        get: ( questionId ) ->
            questions[ questionId ]
        length: () ->
            questions.length
        upload: ( file, onSuccess, onError ) ->
            if phoneCheck.android

                options = new FileUploadOptions()
                ft = new FileTransfer()
                options.fileName = file.file.substr( file.file.lastIndexOf('/') + 1 )
                options.mimeType = 'audio/mp3'
                options.fileKey  = 'record'

                ft.upload( file, encodeURI(uploader), onSuccess, onError, options)
            else
                console.log('Uploading answer')
                uploadRecord file.file, file.name, onSuccess, onError
                return







            
    }