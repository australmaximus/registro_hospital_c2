<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Paciente extends Model
{
    use HasFactory;
    protected $table = 'pacientes';
    public $timestamps = false;
    protected $primaryKey = 'rut_pc';
    public $incrementing = false;
    protected $keyType = 'string';

    // retorna el doctor asociado al paciente
    public function doctor(){
        return $this->belongsTo('App\Models\Doctor','rut_dr');
    }

    public function hospital(){
        return $this->belongsTo('App\Models\Hospital');
    }
}
