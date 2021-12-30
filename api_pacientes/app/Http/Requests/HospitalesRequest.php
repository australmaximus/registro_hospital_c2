<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class HospitalesRequest extends FormRequest
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
            'nombre' => 'required|unique:hospitales,nombre|min:5|max:50',
            'direccion' => 'required|min:5|max:50',
            'telefono' => 'integer|digits:9',
            'num_camas' => 'required|integer|min:10|max:99',
        ];
    }

    public function messages(){
        return [
            'nombre.required' => 'Debe ingresar el nombre del hospital',
            'nombre.unique' => 'El nombre :input ya existe en el sistema',
            'nombre.min' => 'El nombre debe tener 5 letras como mínimo',
            'nombre.max' => 'El nombre puede tener 50 letras como máximo',

            'direccion.required' => 'Debe ingresar el dirección del hospital',
            'direccion.min' => 'La dirección debe tener 5 letras como mínimo',
            'direccion.max' => 'La dirección puede tener 50 letras como máximo',

            'telefono.integer' => 'El teléfono debe ser númerico',
            'telefono.digits' => 'El télefono debe tener 9 dígitos',

            'num_camas.required' => 'El número de camas es obligatorio',
            'num_camas.integer' => 'El número de camas debe ser númerico y entero',
            'num_camas.min' => 'La cantidad mínima de camas debe ser 10',
            'num_camas.max' => 'La cantidad máxima de camas es 99',
        ];
    }
}
