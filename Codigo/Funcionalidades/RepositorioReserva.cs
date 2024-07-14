﻿using Dominio;
using Gestion_de_viajes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Funcionalidades
{
    public class RepositorioReserva
    {


        public List<Reserva> ListarConSp()
        {

            List<Reserva> listarReserva = new List<Reserva>();
            AccesoDatos AccesoDatos = new AccesoDatos();
            try
            {

                AccesoDatos.setearSp("SelReservaCompleto");
                AccesoDatos.ejecutarLectura();

                while (AccesoDatos.Lector.Read())
                {
                    Reserva aux = new Reserva();


                    aux.IdReserva = (int)AccesoDatos.Lector["IdReserva"];
                    aux.DNIUsuario = (int)AccesoDatos.Lector["DNI"];
                    aux.estado = (int)AccesoDatos.Lector["EstadoReserva"];
                    aux.Precio = (decimal)AccesoDatos.Lector["Precio"];
                    aux.IdPaquete = (int)AccesoDatos.Lector["IdPaquete"];


                    listarReserva.Add(aux);
                }

                AccesoDatos.cerrarConexion();
                return listarReserva;

            }


            catch (Exception ex)
            {

                throw ex;
            }

        }

        public void AgregarConSp(Reserva nuevo)
        {
            AccesoDatos accesoDatos = new AccesoDatos();

            try
            {
                accesoDatos.setearSp("insReserva");
                accesoDatos.setearParametros("@DNI", nuevo.DNIUsuario);
                accesoDatos.setearParametros("@EstadoReserva", nuevo.estado);
                accesoDatos.setearParametros("@IdPaquete", nuevo.IdPaquete);
                accesoDatos.setearParametros("@IdHotel", nuevo.idHotel);
                accesoDatos.setearParametros("@Precio", nuevo.Precio);
                accesoDatos.setearParametros("@FechaInicio", nuevo.FechaInicio);

                accesoDatos.ejecutarAccion();



            }
            catch (Exception EX)
            {

                throw EX;
            }

            finally
            {
                accesoDatos.cerrarConexion();
            }



        }
        public Reserva ObtenerReservaPorId(int idReserva)
        {
            Reserva reserva = new Reserva();
            AccesoDatos accesoDatos = new AccesoDatos();

            try
            {
                accesoDatos.setearSp("ObtenerReservaPorId");
                accesoDatos.setearParametros("@IdReserva", idReserva);
                accesoDatos.ejecutarLectura();

                if (accesoDatos.Lector.Read())
                {
                    Reserva aux = new Reserva();

                    aux.IdReserva = (int)accesoDatos.Lector["IdReserva"];
                    aux.DNIUsuario = (int)accesoDatos.Lector["DNI"];
                    aux.estado = (int)accesoDatos.Lector["EstadoReserva"];
                    aux.IdPaquete = (int)accesoDatos.Lector["IdPaquete"];
                    aux.IdPaquete = (int)accesoDatos.Lector["IdHotel"];
                    aux.Precio = (decimal)accesoDatos.Lector["Precio"];
                    reserva = aux;
                }

                accesoDatos.cerrarConexion();
                return reserva;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                accesoDatos.cerrarConexion();
            }

        }


    }
}
