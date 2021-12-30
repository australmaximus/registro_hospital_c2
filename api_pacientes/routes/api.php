<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{HospitalesController,DoctoresController,PacientesController};

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// Route::apiResource('/hospitales', HospitalesController::class);
// Route::apiResource('/doctores', DoctoresController::class);
// Route::apiResource('/pacientes', PacientesController::class);

Route::get('/hospitales',[HospitalesController::class,'index']);
Route::get('/hospitales/{hospital}',[HospitalesController::class,'show']);
Route::post('/hospitales',[HospitalesController::class,'store']);
Route::delete('/hospitales/{hospital}',[HospitalesController::class,'destroy']);
Route::put('/hospitales/{hospital}',[HospitalesController::class,'update']);

Route::get('/doctores',[DoctoresController::class,'index']);
Route::get('/doctores/{doctor}',[DoctoresController::class,'show']);
Route::post('/doctores',[DoctoresController::class,'store']);
Route::delete('/doctores/{doctor}',[DoctoresController::class,'destroy']);
Route::put('/doctores/{doctor}',[DoctoresController::class,'update']);

Route::get('/pacientes',[PacientesController::class,'index']);
Route::get('/pacientes/{paciente}',[PacientesController::class,'show']);
Route::post('/pacientes',[PacientesController::class,'store']);
Route::delete('/pacientes/{paciente}',[PacientesController::class,'destroy']);
Route::put('/pacientes/{paciente}',[PacientesController::class,'update']);