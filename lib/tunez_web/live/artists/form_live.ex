defmodule TunezWeb.Artists.FormLive do
  use TunezWeb, :live_view

  def mount(_params, _session, socket) do
    form = Tunez.Music.form_to_create_artist()

    socket =
      socket
      |> assign(:form, to_form(form))
      |> assign(:page_title, "New Artist")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <Layouts.app {assigns}>
      <.header>
        <.h1>{@page_title}</.h1>
      </.header>

      <.simple_form
        :let={form}
        id="artist_form"
        as={:form}
        for={@form}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={form[:name]} label="Name" />
        <.input field={form[:biography]} type="textarea" label="Biography" />
        <:actions>
          <.button type="primary">Save</.button>
        </:actions>
      </.simple_form>
    </Layouts.app>
    """
  end

  def handle_event("validate", %{"form" => form_data}, socket) do
    socket = socket |> update(:form, fn form -> form |> AshPhoenix.Form.validate(form_data) end)
    {:noreply, socket}
  end

  def handle_event("save", %{"form" => _form_data}, socket) do
    {:noreply, socket}
  end
end
