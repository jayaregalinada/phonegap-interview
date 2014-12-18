<?php

class HomeController extends BaseController {

	public function upload()
	{
		$file = Input::file('record');
		try
		{
			$file->move( public_path('uploads'), Input::get('name') );
		}
		catch( Exception $e )
		{
			return Response::json([
				'error' => [
					'message' => 'Sorry, error occurred during uploading',
					'$e' => $e->getMessage()
				]
			], 500);
		}
		return Response::json([
			'success' => [
				'message' => 'You may now proceed to next question',
				'new' => Input::get('name')
			]
		], 200);

	}

	public function index()
	{
		return View::make('index');
	}

	public function sendMail()
	{
		$data = Input::get('data');
		Mail::send('applicant', [ 'data' => $data ], function( $message ) use ($data)
		{
			$message->to('jayaregalinada@gmail.com', 'JAG Interview App PHP')
					->subject('Applicant '. $data['email']);
			$message->from( $data['email'], 'APPLICANT: ' . $data['email'] );
			foreach( $data['records'] as $key => $value )
			{
				$message->attach( public_path('uploads') . '/'. $value );
			}
		});
	}

}
