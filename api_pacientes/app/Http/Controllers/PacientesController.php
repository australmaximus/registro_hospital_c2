<?php

namespace App\Http\Controllers;

use App\Models\Paciente;
use App\Http\Requests\PacientesRequest;
use App\Http\Requests\Pacientes2Request;
use Illuminate\Http\Request;

class PacientesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $pacientes = Paciente::orderBy('nombre')->get();
        foreach($pacientes as $paciente){
            $paciente->doctor->hospital;
        }
        return $pacientes;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(PacientesRequest $request)
    {
        $paciente = new Paciente();
        $paciente->rut_pc = $request->rut_pc;
        $paciente->nombre = $request->nombre;
        $paciente->apellido = $request->apellido;
        $paciente->apellido2 = $request->apellido2;
        $paciente->prevision = $request->prevision;
        $paciente->tipo_atencion = $request->tipo_atencion;
        $paciente->edad = $request->edad;
        $paciente->rut_dr = $request->rut_dr;
        $paciente->save();
        return $paciente;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Paciente  $paciente
     * @return \Illuminate\Http\Response
     */
    public function show(Paciente $paciente)
    {
        $paciente->load(['doctor' => function ($query) {
            $query->with('hospital');
        }]);
        return $paciente;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Paciente  $paciente
     * @return \Illuminate\Http\Response
     */
    public function update(Paciente $paciente, Pacientes2Request $request)
    {
        $paciente->rut_pc = $request->rut_pc;
        $paciente->nombre = $request->nombre;
        $paciente->apellido = $request->apellido;
        $paciente->apellido2 = $request->apellido2;
        $paciente->prevision = $request->prevision;
        $paciente->tipo_atencion = $request->tipo_atencion;
        $paciente->edad = $request->edad;
        $paciente->rut_dr = $request->rut_dr;
        $paciente->save();
        return $paciente;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Paciente  $paciente
     * @return \Illuminate\Http\Response
     */
    public function destroy(Paciente $paciente)
    {
        $paciente->delete();
    }
}
