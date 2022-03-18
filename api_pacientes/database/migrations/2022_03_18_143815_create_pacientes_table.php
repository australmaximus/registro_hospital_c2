<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pacientes', function (Blueprint $table) {
            $table->string('rut_pc',12)->primary();
            $table->string('nombre',20);
            $table->string('apellido',20);
            $table->string('apellido2',20);
            $table->string('prevision',20);
            $table->integer('tipo_atencion')->unsigned();
            $table->integer('edad')->unsigned();
            $table->string('rut_dr',12);
            $table->foreign('rut_dr')->references('rut_dr')->on('doctores');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pacientes');
    }
};
