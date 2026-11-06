<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\MahasiswaController;

Route::apiResource('mahasiswa', MahasiswaController::class);