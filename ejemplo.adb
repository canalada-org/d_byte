-- Andres Soliño
-- 3-7-05
with D_Byte;
use D_Byte;

procedure Ejemplo is 

   B               : Byte;  
   Archivo_Entrada,  
   Archivo_Salida  : T_Binary_file;  

begin
   Open(Archivo_Entrada,In_File,"prueba.jpg");
   Create(Archivo_Salida,Out_File,"duplicado.jpg");
   while not End_Of_File(Archivo_Entrada) loop
      Read(Archivo_Entrada,B);
      Write(Archivo_Salida,B);
   end loop;
   Close(Archivo_Entrada);
   Close(Archivo_Salida);
end Ejemplo;
   


