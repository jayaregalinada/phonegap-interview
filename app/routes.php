<?php
Route::get('/', ['as' => 'index', 'uses' => 'HomeController@index']);

Route::post('uploader', ['as' => 'uploader', 'uses' => 'HomeController@upload']);

Route::post('mail', ['as' => 'mail', 'uses' => 'HomeController@sendMail']);