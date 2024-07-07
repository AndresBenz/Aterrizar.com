﻿<%@ Page Title="Administrador" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Administrador.aspx.cs" Inherits="Gestion_de_viajes.Administrador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .admin-container {
            width: 80%;
            margin: 30px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #2c3e50;
        }

        .section {
            margin-top: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ccc;
        }

            .section:last-child {
                border-bottom: none;
            }

        label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }

        input[type="text"],
        input[type="number"],
        textarea {
            padding: 10px;
            width: 100%;
            max-width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 10px;
            font-size: 16px;
        }

        select {
            padding: 10px;
            width: 100%;
            max-width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 10px;
            font-size: 16px;
        }

        .btn-primary {
            display: inline-block;
            padding: 10px 20px;
            background-color: #3498db;
            color: #fff;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
            cursor: pointer;
        }

            .btn-primary:hover {
                background-color: #2980b9;
            }

        .form-group {
            margin-bottom: 20px;
        }

        .list-group {
            margin-bottom: 10px;
        }

        .list-group-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-container">
        <h1>Administrador de Paquetes de Viaje</h1>

        <!--EMPIEZA ABM PAQUETE-->

        <div class="section">
            <h2>Gestionar Paquetes</h2>


            <!--botones-->

            <asp:Button ID="btnAgregarPaquete" runat="server" Text="Agregar Paquete" CssClass="btn-primary" OnClick="btnAgregarPaquete_Click" />
            <asp:Button ID="btnModificarPaquete" runat="server" Text="Modificar Paquete" CssClass="btn-primary" OnClick="btnModificarPaquete_Click" />
            <asp:Button ID="btnEliminarPaquete" runat="server" Text="Eliminar Paquete" CssClass="btn-primary" OnClick="btnEliminarPaquete_Click" />



            <!--ABM DE PAQUETE-->
            <asp:PlaceHolder ID="PhABMPaquete" runat="server" Visible="false">
                <div class="form-group">

                    <asp:Label runat="server" ID="lbidPquete">Seleccionar id paquete</asp:Label>
                    <asp:DropDownList runat="server" ID="ddlIdPaquete" AutoPostBack="true" OnSelectedIndexChanged="ddlIdPaquete_SelectedIndexChanged"></asp:DropDownList>

                </div>
                <div class="form-group">

                    <asp:Label ID="lblDestPaquete" Text="Seleccionar el destino del paquete:" runat="server" />
                    <asp:DropDownList ID="ddlCdgDestino" AutoPostBack="true" runat="server"></asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="txtNombrePaquete">Nombre del Paquete:</label>
                    <asp:TextBox ID="txtNombrePaquete" runat="server"></asp:TextBox>

                </div>

                <div class="form-group">
                    <label for="txtDescripcionPaquete">Descripción:</label>
                    <asp:TextBox ID="txtDescripcionPaquete" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="txtPrecioPaquete">Precio:</label>
                    <asp:TextBox ID="txtPrecioPaquete" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtMes">Mes:</label>
                    <asp:DropDownList ID="ddlmes" runat="server">
                        <asp:ListItem Value="1" Text="Enero" />
                        <asp:ListItem Value="2" Text="Febrero" />
                        <asp:ListItem Value="3" Text="Marzo" />
                        <asp:ListItem Value="4" Text="Abril" />
                        <asp:ListItem Value="5" Text="Mayo" />
                        <asp:ListItem Value="6" Text="Junio" />
                        <asp:ListItem Value="7" Text="Julio" />
                        <asp:ListItem Value="8" Text="Agosto" />
                        <asp:ListItem Value="9" Text="Septiembre" />
                        <asp:ListItem Value="10" Text="Octubre" />
                        <asp:ListItem Value="11" Text="Noviembre" />
                        <asp:ListItem Value="12" Text="Diciembre" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="txtDuracionPaquete">Duración:</label>
                    <asp:TextBox ID="txtDuracionPaquete" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="ddlTipoTransporte">Tipo de Transporte:</label>
                    <asp:DropDownList ID="ddlTipoTransporte" runat="server">
                        <asp:ListItem Text="Avión" Value="1" />
                        <asp:ListItem Text="Bus" Value="2" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="txtURLimagen">URL de la Imagen:</label>
                    <asp:TextBox ID="txtURLimagen" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtDisponibilidadPaquete">Disponibilidad:</label>
                    <asp:TextBox ID="txtDisponibilidadPaquete" runat="server"></asp:TextBox>
                </div>
                <!--Boton al agregar paquete-->

                <asp:Button ID="btnGuardarPaquete" runat="server" Text="Guardar Paquete" CssClass="btn-primary" OnClick="btnGuardarPaquete_Click" />
                <!--Boton al aceptar la modificacion del paquete-->

                <asp:Button ID="btnAceptarModificarPaquete" runat="server" Text="Aceptar modificacion del Paquete" CssClass="btn-primary" OnClick="btnAceptarModificarPaquete_Click" />
                <!--Boton al eliminar paquete-->

                <asp:Button ID="btnEliminarPaqueteBoton" runat="server" Text="Eliminar Paquete" CssClass="btn-primary" Visible="false" OnClientClick="return confirm('¿Esta seguro que desea eliminar este paquete?');" OnClick="btnEliminarPaqueteBoton_Click" />

                <asp:Label ID="lblConfirmacion" runat="server" CssClass="success-message" Visible="false"></asp:Label>
            </asp:PlaceHolder>

            <asp:PlaceHolder ID="phEliminarPaquete" runat="server" Visible="false">
                <div class="form-group">
                </div>
            </asp:PlaceHolder>
        </div>
        <!--TERMINA ABM PAQUETE-->



        <!--ABM HOTELES-->

        <div class="section">
            <h2>Agregar Hoteles al Paquete</h2>
            <!--Botones principales-->

            <asp:Button ID="btnAgregarHotel" runat="server" Text="Agregar Hotel" CssClass="btn-primary" OnClick="btnAgregarHotel_Click" />
            <asp:Button ID="btnModificarHotel" runat="server" Text="Modificar Hotel" CssClass="btn-primary" OnClick="btnModificarHotel_Click" />
            <asp:Button ID="btnElminarHotel" runat="server" Text="Eliminar Hotel" CssClass="btn-primary" OnClick="btnElminarHotel_Click" />
            <!--ABM HOTELES-->

            <asp:PlaceHolder ID="PhABMHotel" runat="server" Visible="false">
                <div class="form-group">

                    <asp:Label runat="server" ID="lbIdHotel">Seleccionar id Hotel </asp:Label>
                    <asp:DropDownList runat="server" ID="ddlIdHoteles" AutoPostBack="true" OnSelectedIndexChanged="ddlIdHoteles_SelectedIndexChanged"></asp:DropDownList>
                </div>


                <div class="form-group">
                    <label for="txtNombreHotel">Nombre del Hotel:</label>
                    <asp:TextBox ID="txtNombreHotel" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtDescripcionHotel">Descripción:</label>
                    <asp:TextBox ID="txtDescripcionHotel" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtPrecioHotel">Precio por Noche:</label>
                    <asp:TextBox ID="txtPrecioHotel" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">

                    <asp:Label ID="lbCdgDestinoEnHotel" Text="Seleccionar el destino del Hotel:" runat="server" />
                    <asp:DropDownList ID="ddlCdgDestinoEnHotel" AutoPostBack="true" runat="server"></asp:DropDownList>

                </div>
                <div class="form-group">
                    <label for="lbURLImagen">UrlImagen:</label>
                    <asp:TextBox ID="txtURLImagenHotel" runat="server"></asp:TextBox>
                </div>
                <!--Boton al agregar hotel-->

                <asp:Button ID="btnGuardarHotel" runat="server" Text="Agregar Hotel al Paquete" CssClass="btn-primary" OnClick="btnGuardarHotel_Click" />

                <!--Boton al modificar hotel-->

                <asp:Button ID="btnAceptarModificarHotel" runat="server" Text="Aceptar modificacion del hotel" CssClass="btn-primary" OnClick="btnAceptarModificarHotel_Click" />

                <!--Boton al elimnar hotel-->


                <asp:Button ID="btnEliminarHotelboton" runat="server" Text="Elimnar Hotel" CssClass="btn-primary" OnClientClick="return confirm('¿Esta seguro que desea eliminar este hotel?')" OnClick="btnEliminarHotelboton_Click" />
                <asp:Label ID="lbConfirmacionEliminacionHotel" runat="server" CssClass="success-message" Visible="false"></asp:Label>


            </asp:PlaceHolder>
        </div>

        <!--TERMINA ABM HOTEL-->

        <!--INICIO ABM EXCURSION-->

        <div class="section">
            <h2>Agregar Excursiones al Paquete</h2>
            <asp:Button ID="btnAgregarExcursion" runat="server" Text="Agregar Excursion" CssClass="btn-primary" OnClick="btnAgregarExcursion_Click" />
            <asp:Button ID="btnModificarExcursion" runat="server" Text="Modificar Excursion" CssClass="btn-primary" OnClick="btnModificarExcursion_Click" />
            <asp:Button ID="btnEliminarExcursion" runat="server" Text="Eliminar Excursion" CssClass="btn-primary" OnClick="btnEliminarExcursion_Click" />

            <asp:PlaceHolder ID="phABMExcursion" runat="server" Visible="false">
                <div class="form-group">
                    <label id="lbidExcursion" runat="server">Seleccionar id excursion:</label>
                    <asp:DropDownList ID="ddlIdExcursion" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlIdExcursion_SelectedIndexChanged"></asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="txtNombreExcursion">Nombre de la Excursión:</label>
                    <asp:TextBox ID="txtNombreExcursion" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtDescripcionExcursion">Descripción:</label>
                    <asp:TextBox ID="txtDescripcionExcursion" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">

                    <asp:Label ID="lbCdgDestinoEnExcursion" Text="Seleccionar el destino de la excrusion:" runat="server" />
                    <asp:DropDownList ID="ddlCdgDestinoEnExcursion" AutoPostBack="true" runat="server"></asp:DropDownList>

                </div>
                <div class="form-group">
                    <label for="lbDuracion">Duracion de la excursion (en horas):</label>
                    <asp:TextBox ID="txtDuracionExcursion" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="txtPrecioExcursion">Precio:</label>
                    <asp:TextBox ID="txtPrecioExcursion" runat="server"></asp:TextBox>
                </div>
                <!--Boton al agregar Excursion-->

                <asp:Button ID="btnGuardarExcursion" runat="server" Text="Agregar Excursión al Paquete" CssClass="btn-primary" OnClick="btnGuardarExcursion_Click" />

                <!--Boton al modificar hotel-->

                <asp:Button ID="btnAceptarModificarExcursion" runat="server" Text="Aceptar modificacion de la excursion" CssClass="btn-primary" OnClick="btnAceptarModificarExcursion_Click" />

                <!--Boton al elimnar hotel-->


                <asp:Button ID="btnaceptarEliminarExcursion" runat="server" Text="Elimnar Excursion" CssClass="btn-primary" OnClientClick="return confirm('¿Esta seguro que desea eliminar este hotel?')" OnClick="btnaceptarEliminarExcursion_Click" />
                <asp:Label ID="Label1" runat="server" CssClass="success-message" Visible="false"></asp:Label>



            </asp:PlaceHolder>
        <!--INICIO MESES-->
            <asp:PlaceHolder ID="phABMMes" runat="server" Visible="true">
       
                <asp:Label Text="meses activos" runat="server" />
                <asp:DropDownList ID="ddlMesesactivos" runat="server" ></asp:DropDownList>
                <asp:Button Text="descativar mes" ID="btn" runat="server" />
                
        
            </asp:PlaceHolder>
        </div>

        <!--FIN ABM EXCURSION-->

    </div>
</asp:Content>
<%--<h3>Excursiones en el Paquete</h3>
                <asp:ListBox ID="lstExcursiones" runat="server" CssClass="list-group"></asp:ListBox>--%>
