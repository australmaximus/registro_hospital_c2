<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PacientesRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'rut_pc' => 'required|unique:pacientes,rut_pc|min:11|max:12',
            'nombre' => 'required|min:3|max:20',
            'apellido' => 'required|min:3|max:20',
            'apellido2' => 'required|min:3|max:20',
            'prevision' => 'required|min:5|max:20',
            'tipo_atencion' => 'integer|min:1',
            'edad' => 'required|integer|min:1|max:99',
            'rut_dr' => 'required',
        ];
    }

    public function messages(){
        return[
            'rut_pc.required' => 'El RUT es obligatorio',
            'rut_pc.unique' => 'El RUT :input ya existe en el sistema',
            'rut_pc.min' => 'El RUT debe tener 11 carácteres como mínimo',
            'rut_pc.max' => 'El nombre puede tener 12 carácteres como máximo',

            'nombre.required' => 'Debe ingresar el nombre del paciente',
            'nombre.min' => 'El nombre debe tener 3 letras como mínimo',
            'nombre.max' => 'El nombre puede tener 20 letras como máximo',

            'apellido.required' => 'Debe ingresar el apellido del paciente',
            'apellido.min' => 'El apellido debe tener 3 letras como mínimo',
            'apellido.max' => 'El apellido puede tener 20 letras como máximo',

            'apellido2.required' => 'Debe ingresar el segundo apellido del paciente',
            'apellido2.min' => 'El segundo apellido debe tener 3 letras como mínimo',
            'apellido2.max' => 'El segundo apellido puede tener 20 letras como máximo',

            'prevision.required' => 'Debe ingresar la prevision del paciente',
            'prevision.min' => 'La prevision debe tener 5 letras como mínimo',
            'prevision.max' => 'La prevision puede tener 20 letras como máximo',

            'tipo_atencion.integer' => 'Debe seleccionar un tipo de atención',
            'tipo_atencion.min' => 'Debe seleccionar un tipo de atención',

            'edad.required' => 'La edad es obligatoria',
            'edad.integer' => 'La edad debe ser númerica y entera',
            'edad.min' => 'La edad debe ser mínimo 1',
            'edad.max' => 'La edad no puede ser mayor a 99',

            'rut_dr.required' => 'Debe seleccionar un doctor',
        ];
    }
}
