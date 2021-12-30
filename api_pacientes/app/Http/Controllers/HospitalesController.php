<?php

namespace App\Http\Controllers;

use App\Models\Hospital;
use App\Http\Requests\HospitalesRequest;
use App\Http\Requests\Hospitales2Request;
use Illuminate\Http\Request;

class HospitalesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Hospital::orderBy('nombre')->get();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(HospitalesRequest $request)
    {
        $hospital = new Hospital();
        $hospital->nombre = $request->nombre;
        $hospital->direccion = $request->direccion;
        $hospital->telefono = $request->telefono;
        $hospital->num_camas = $request->num_camas;
        $hospital->save();
        return $hospital;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Hospital  $hospital
     * @return \Illuminate\Http\Response
     */
    public function show(Hospital $hospital)
    {
        return $hospital;
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Hospital  $hospital
     * @return \Illuminate\Http\Response
     */
    public function update(Hospital $hospital, Hospitales2Request $request)
    {
        $hospital->nombre = $request->nombre;
        $hospital->direccion = $request->direccion;
        $hospital->telefono = $request->telefono;
        $hospital->num_camas = $request->num_camas;
        $hospital->save();
        return $hospital;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Hospital  $hospital
     * @return \Illuminate\Http\Response
     */
    public function destroy(Hospital $hospital)
    {
        $hospital->delete();
    }
}
