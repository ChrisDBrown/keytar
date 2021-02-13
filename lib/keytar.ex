defmodule Keytar do
  @moduledoc """
  Blink keybow keypad forever.
  """

  # Durations are in milliseconds
  @on_duration 200
  @off_duration 200

  alias Circuits.SPI
  require Logger

  def start(_type, _args) do
    led_list = Application.get_env(:keytar, :led_list)
    Logger.debug("list of leds to blink is #{inspect(led_list)}")

    {:ok, spidev} = SPI.open("spidev0.0", speed_hz: 4000000)
    spawn(fn -> blink_forever(spidev) end)
    {:ok, self()}
  end

  defp blink_forever(spidev) do
    blink(spidev)
    blink_forever(spidev)
  end

  defp blink(spidev) do
    SPI.transfer(spidev, <<0, 0, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 227, 255, 0, 0, 255, 255, 255, 255>>)
    :timer.sleep(@on_duration)
    SPI.transfer(spidev, <<0, 0, 0, 0, 227, 0, 255, 0, 227, 0, 255, 0, 227, 0, 255, 0, 227, 0, 255, 0, 227, 0, 255, 0, 227, 0, 255, 0, 227, 0, 255, 0, 227, 0, 255, 0, 227, 0, 255, 0, 227, 0, 255, 0, 227, 0, 255, 0, 227, 0, 255, 0, 255, 255, 255, 255>>)
    :timer.sleep(@on_duration)
    SPI.transfer(spidev, <<0, 0, 0, 0, 227, 0, 0, 255, 227, 0, 0, 255, 227, 0, 0, 255, 227, 0, 0, 255, 227, 0, 0, 255, 227, 0, 0, 255, 227, 0, 0, 255, 227, 0, 0, 255, 227, 0, 0, 255, 227, 0, 0, 255, 227, 0, 0, 255, 227, 0, 0, 255, 255, 255, 255, 255>>)
    :timer.sleep(@off_duration)
  end
end
