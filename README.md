# Selfie

Figuring out what works with a self-referencing polymorphic embbeded schema in a form in Surface and LiveView.

## Works

 * Using LiveView - `localhost:4000/liveview`
 * Using Surface w/Phoenix.Component - `localhost:4000/surface/phoenix_component`
 * Using Surface w/Surface.Component and passing the `form` as a `prop` aka `assign` - `localhost:4000/surface/1`

## Does not works

 * Expecting the `Context` to pass down auto-magically
 * `localhost:4000/surface/2` to `localhost:4000/surface/5`

## To start your Phoenix server:

  * `mix deps.get`
  * `iex -S mix phx.server`
