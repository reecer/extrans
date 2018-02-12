defmodule ExTrans.Session do
  alias ExTrans.Base

  def set do
    Base.call("session-set")
  end

  def get do
    Base.call("session-get")
  end

  def stats do
    Base.call("session-stats")
  end

  def close do
    Base.call("session-close")
  end
end