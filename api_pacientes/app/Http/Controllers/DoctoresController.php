<?php

namespace App\Http\Controllers;

use App\Models\Doctor;
use App\Http\Requests\DoctoresRequest;
use App\Http\Requests\Doctores2Request;
use Illuminate\Http\Request;

class DoctoresController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $doctores = Doctor::orderBy('nombre')->get();
        foreach($doctores as $doctor){
            $doctor->hospital;
        }
        return $doctores;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(DoctoresRequest $request)
    {
        $doctor = new Doctor();
        $doctor->rut_dr = $request->rut_dr;
        $doctor->nombre = $request->nombre;
        $doctor->apellido = $request->apellido;
        $doctor->apellido2 = $request->apellido2;
        $doctor->especialidad = $request->especialidad;
        $doctor->hospital_id = $request->hospital_id;
        $doctor->save();
        return $doctor;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Doctor  $doctor
     * @return \Illuminate\Http\Response
     */
    public function show(Doctor $doctor)
    {
        $doctor->load('hospital');
        return $doctor;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Doctor  $doctor
     * @return \Illuminate\Http\Response
     */
    public function update(Doctor $doctor, Doctores2Request $request)
    {
        $doctor->rut_dr = $request->rut_dr;
        $doctor->nombre = $request->nombre;
        $doctor->apellido = $request->apellido;
        $doctor->apellido2 = $request->apellido2;
        $doctor->especialidad = $request->especialidad;
        $doctor->hospital_id = $request->hospital_id;
        $doctor->save();
        return $doctor;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Doctor  $doctor
     * @return \Illuminate\Http\Response
     */
    public function destroy(Doctor $doctor)
    {
        $doctor->delete();
    }
}
