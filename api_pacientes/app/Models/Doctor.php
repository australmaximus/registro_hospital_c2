<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Doctor extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'doctores';
    protected $primaryKey = 'rut_dr';
    public $incrementing = false;
    protected $keyType = 'string';

    // retorna el hospital asociado a doctor
    public function hospital(){
        //return $this->belongsTo(Hospital::class);
        return $this->belongsTo('App\Models\Hospital');
    }

    // retorna los pacientes asociados al doctor
    public function pacientes(){
        return $this->hasMany(Paciente::class);
    }
}
