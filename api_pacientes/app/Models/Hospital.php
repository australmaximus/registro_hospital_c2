<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Hospital extends Model
{
    use HasFactory, SoftDeletes;
    protected $table = 'hospitales';

    //retorna los doctores asociados al hospital
    public function doctores(){
        return $this->hasMany(Doctor::class);
    }

    public function pacientes(){
        return $this->hasMany(Paciente::class);
    }
}
