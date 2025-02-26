defmodule MyApp.Facility.RegisterAreaTest do
  use MyApp.CqrsCase

  alias MyApp.Facility

  @nonexistent_area_id "area#123"

  describe "register_area/2" do
    @tag :integration
    test "with invalid params returns a :validation_failure error" do
      assert {:error, {:validation_failure, _changeset}} =
               Facility.register_area(%{})
    end

    @tag :integration
    test "with valid params returns an area identity" do
      assert {:ok, %{area_id: area_id}} =
               Facility.register_area(%{
                 name: "Building A"
               })

      assert is_binary(area_id)
    end

    @tag :integration
    test "with a specified 'area_id' returns an area identity with a different id than the specified one" do
      assert {:ok, %{area_id: area_id}} =
               Facility.register_area(%{
                 area_id: @nonexistent_area_id,
                 name: "Building A"
               })

      assert is_binary(area_id) and area_id != @nonexistent_area_id
    end

    @tag :integration
    test "with valid params as a map with string keys raises a Ecto.CastError" do
      assert_raise Ecto.CastError, fn ->
        Facility.register_area(%{
          "area_id" => @nonexistent_area_id,
          "name" => "Building A"
        })
      end
    end
  end
end
