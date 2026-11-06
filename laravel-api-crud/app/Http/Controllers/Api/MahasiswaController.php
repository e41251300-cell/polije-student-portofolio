<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Mahasiswa;
use Illuminate\Http\Request;

class MahasiswaController extends Controller
{
    public function index()
    {
        $mahasiswa = Mahasiswa::all();
        return response()->json([
            'status' => 'success',
            'data' => $mahasiswa
        ], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'nama' => 'required|string|max:255',
            'nim' => 'required|string|unique:mahasiswas,nim',
            'jurusan' => 'required|string|max:255',
        ]);

        $mahasiswa = Mahasiswa::create($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Data mahasiswa berhasil ditambahkan',
            'data' => $mahasiswa
        ], 201);
    }

    public function show($id)
    {
        $mahasiswa = Mahasiswa::find($id);
        if (!$mahasiswa) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }
        return response()->json([
            'status' => 'success',
            'data' => $mahasiswa
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $mahasiswa = Mahasiswa::find($id);
        if (!$mahasiswa) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }

        $validated = $request->validate([
            'nama' => 'required|string|max:255',
            'nim' => 'required|string|unique:mahasiswas,nim,' . $id,
            'jurusan' => 'required|string|max:255',
        ]);

        $mahasiswa->update($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Data berhasil diperbarui',
            'data' => $mahasiswa
        ], 200);
    }

    public function destroy($id)
    {
        $mahasiswa = Mahasiswa::find($id);
        if (!$mahasiswa) {
            return response()->json(['message' => 'Data tidak ditemukan'], 404);
        }

        $mahasiswa->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Data berhasil dihapus'
        ], 200);
    }
}