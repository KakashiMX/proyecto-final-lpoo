/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

// verifica que se haya iniciado sesión
const nombreUsu= localStorage.getItem("Usuario");

if( nombreUsu === null){
    
    alert("No tienes permisos para ver esta página");
    window.location.href = 'http://localhost:8080/Hotel_Reservas/';
}