<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class Doctores2Request extends FormRequest
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
            'rut_dr' => 'required|min:11|max:12',
            
            'nombre' => 'required|min:3|max:20',
            'apellido' => 'required|min:3|max:20',
            'apellido2' => 'required|min:3|max:20',
            'especialidad' => 'required|min:5|max:20',
            'hospital_id' => 'integer|min:1',
        ];
    }
    
    public function messages(){
        return[
            'rut_dr.required' => 'El RUT es obligatorio',
            'rut_dr.min' => 'El RUT debe tener 11 carácteres como mínimo',
            'rut_dr.max' => 'El RUT puede tener 12 carácteres como máximo',

            'nombre.required' => 'Debe ingresar el nombre del doctor',
            'nombre.min' => 'El nombre debe tener 3 letras como mínimo',
            'nombre.max' => 'El nombre puede tener 20 letras como máximo',

            'apellido.required' => 'Debe ingresar el apellido del doctor',
            'apellido.min' => 'El apellido debe tener 3 letras como mínimo',
            'apellido.max' => 'El apellido puede tener 20 letras como máximo',

            'apellido2.required' => 'Debe ingresar el segundo apellido del doctor',
            'apellido2.min' => 'El segundo apellido debe tener 3 letras como mínimo',
            'apellido2.max' => 'El segundo apellido puede tener 20 letras como máximo',

            'especialidad.required' => 'Debe ingresar la especialidad del doctor',
            'especialidad.min' => 'La especialidad debe tener 5 letras como mínimo',
            'especialidad.max' => 'La especialidad puede tener 20 letras como máximo',

            'hospital_id.integer' => 'Debe seleccionar un hospital',
            'hospital_id.min' => 'Debe seleccionar un hospital',
        ];
    }
}
