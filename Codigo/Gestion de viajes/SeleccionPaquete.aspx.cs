﻿using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Funcionalidades;
namespace Gestion_de_viajes
{
    public partial class Detalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int idPaquete = Convert.ToInt32(Request.QueryString["id"]);
                CargarDetallePaquete(idPaquete);
                PrimerHotel();
                UpFechas.Visible = false;
            upPasajero.Visible = false;
            }
        }

        private void PrimerHotel()
        {
            if (ddlHoteles.SelectedItem == null)
            {
                imgHotel.ImageUrl = "";
                detalleHotel.Text = "";
                return;
            }

            RepositorioHotel repoHotel = new RepositorioHotel();
            int idHotel = int.Parse(ddlHoteles.SelectedItem.Value);

            Hotel hotelSeleccionado = repoHotel.ObtenerHotelPorId(idHotel);
            if (hotelSeleccionado != null)
            {
                imgHotel.ImageUrl = hotelSeleccionado.URLimagen;
                detalleHotel.Text = hotelSeleccionado.Descripcion;
                PrecioHotel.Text = hotelSeleccionado.PrecioPorNoche.ToString();
            }
        }
        private void CargarDetalleHotel(int cdgDestino)
        {
            RepositorioHotel repoHotel = new RepositorioHotel();
            List<Hotel> ListaHoteles = repoHotel.SelHotelCompletoPorDestino(cdgDestino);
            if (ListaHoteles != null)
            {
                ddlHoteles.DataSource = ListaHoteles;
                ddlHoteles.DataTextField = "NombreHotel";
                ddlHoteles.DataValueField = "idHotel";
                ddlHoteles.DataBind();
            }
        }
        private void CargarDetallePaquete(int idPaquete)
        {
            RepositorioPaquete repositorio = new RepositorioPaquete();
            PaqueteDeViaje paquete = repositorio.ObtenerPaquetePorId(idPaquete); 
            if (paquete != null)
            {
                imgPaquete.ImageUrl = paquete.URLimagen;
                lbNombrePaquete.Text = paquete.NombrePaquete;
                int cdgdestino = paquete.cdgDestino;
                lbduracionpaquete.Text = paquete.Duracion.ToString() + " Días";
                CargarDetalleHotel(cdgdestino);
                CargarExcursiones(cdgdestino);
                ActualizarReservaTotal(idPaquete, new List<int>());
            }
        }
        protected void ddlHoteles_SelectedIndexChanged(object sender, EventArgs e)
        {
            RepositorioHotel repoHotel = new RepositorioHotel();
            int idHotel = int.Parse(ddlHoteles.SelectedItem.Value);

            Hotel hotelSeleccionado = repoHotel.ObtenerHotelPorId(idHotel);
            if (hotelSeleccionado != null)
            {
                imgHotel.ImageUrl = hotelSeleccionado.URLimagen;
                detalleHotel.Text = hotelSeleccionado.Descripcion;
                PrecioHotel.Text = hotelSeleccionado.PrecioPorNoche.ToString();
                foreach (ListItem item in excursionesAdicionales.Items)
                {
                    item.Selected = false;
                }
                int idPaquete = Convert.ToInt32(Request.QueryString["id"]);
                
                ActualizarReservaTotal(idPaquete, new List<int>());
                    
            }
        }
        protected void excursionesAdicionales_SelectedIndexChanged(object sender, EventArgs e)
        {
            List<int> idsExcursionesSeleccionadas = new List<int>();
            Reserva aux = new Reserva();
            RepositorioExcursiones repositorioExcursiones = new RepositorioExcursiones();
            foreach (ListItem item in excursionesAdicionales.Items)
            {
                if (item.Selected)
                {
                    idsExcursionesSeleccionadas.Add(Convert.ToInt32(item.Value));
                    //           aux.SelExcursiones.Add(repositorioExcursiones.ObtenerExcursionesPorId(Convert.ToInt32(item.Value)));
                }

                if (!item.Selected)
                {
                    //      aux.SelExcursiones.Remove(repositorioExcursiones.ObtenerExcursionesPorId(Convert.ToInt32(item.Value)));
                }
            }

            ddlHoteles.DataBind();
            int idPaquete = Convert.ToInt32(Request.QueryString["id"]);
            ActualizarReservaTotal(idPaquete, idsExcursionesSeleccionadas);
        }
        private void CargarExcursiones(int cdgDestino)
        {
            RepositorioExcursiones repoExcursion = new RepositorioExcursiones();
            List<Excursiones> excursiones = repoExcursion.ObtenerExcursionesPorDestino(cdgDestino);
            List<Excursiones> excursionesConDescripcion = new List<Excursiones>();

            var excursionesIncluidasFiltradas = excursiones.Where(e => e.duracion <= 5).ToList();
            var excursionesAdicionalesFiltradas = excursiones.Where(e => e.duracion > 5).ToList();

            excursionesIncluidas.DataSource = excursionesIncluidasFiltradas;
            excursionesIncluidas.DataTextField = "Nombre";
            excursionesIncluidas.DataValueField = "IdExcursion";
            excursionesIncluidas.DataBind();

            foreach (var aux in excursiones)
            {
                if (aux.duracion <= 5)
                {
                    excursionesConDescripcion.Add(aux);
                }
            }

            detalleExcursiones.DataSource = excursionesConDescripcion;
            detalleExcursiones.DataTextField = "Descripcion";
            detalleExcursiones.DataValueField = "IdExcursion";
            detalleExcursiones.DataBind();
                
                

            excursionesAdicionales.DataSource = excursionesAdicionalesFiltradas;
            excursionesAdicionales.DataTextField = "Nombre";
            excursionesAdicionales.DataValueField = "IdExcursion";
            excursionesAdicionales.DataBind();

            //excursionesAdicionales.DataSource = excursionesAdicionalesFiltradas;
            //excursionesAdicionales.DataTextField = "Nombre " + "Precio";
            //excursionesAdicionales.DataValueField = "IdExcursion";
            //excursionesAdicionales.DataBind();
        }
        private void ActualizarReservaTotal(int idPaquete, List<int> idsExcursiones)
        {
            RepositorioPaquete repopaquete = new RepositorioPaquete();
            PaqueteDeViaje paquete = repopaquete.ObtenerPaquetePorId(idPaquete);

            decimal precioTotal = paquete.PrecioPaquete;
            int duracionPaquete = paquete.Duracion;

            if (ddlHoteles.SelectedItem != null)
            {
                int idHotel = int.Parse(ddlHoteles.SelectedItem.Value);
                RepositorioHotel repoHotel = new RepositorioHotel();
                Hotel hotelSeleccionado = repoHotel.ObtenerHotelPorId(idHotel);

                if (hotelSeleccionado != null)
                {
                    precioTotal += hotelSeleccionado.PrecioPorNoche * duracionPaquete;
                }
            }

            if (idsExcursiones != null)
            {
                RepositorioExcursiones repoExcursiones = new RepositorioExcursiones();
                foreach (int idExcursion in idsExcursiones)
                {
                    Excursiones excursion = repoExcursiones.ObtenerExcursionesPorId(idExcursion);
                    if (excursion != null)
                    {
                        precioTotal += excursion.Precio;
                    }
                }
            }
           
                reservaTotal.Text = "Reserva Total: $" + precioTotal.ToString();
            
        }
        protected void BtnFechas_Click(object sender, EventArgs e)
        {
            UpFechas.Visible = true;
            UpPrincipalesPaquete.Visible = false;
            UpExcursiones.Visible = false;
            UpHotel.Visible = false;
            BtnFechas.Visible = false;
            List<Fechas> listafechas = new List<Fechas>();

            RepositorioFecha repofechas = new RepositorioFecha();
            RepositorioPaquete repopaquete = new RepositorioPaquete();
            Fechas auxfecha = new Fechas();
            int idPaquete = Convert.ToInt32(Request.QueryString["id"]);
            PaqueteDeViaje aux = repopaquete.ObtenerPaquetePorId(idPaquete);
            int mesSeleccionado = aux.Mes;
            listafechas = repofechas.ListarConSpPorMes(mesSeleccionado);

            repFechas.DataSource = listafechas;
            repFechas.DataBind();

        }
        
        protected void btnElegirFecha_Click(object sender, EventArgs e)
        {
            string IdFecha = ((Button)sender).CommandArgument; // posible variable fuera para tomarla 
            UpFechas.Visible = false;
            upPasajero.Visible = true;

           



        }
    }
}
