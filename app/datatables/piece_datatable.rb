class PieceDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :edit_piece_path, :piece_path

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Piece.id" },
      title: { source: "Piece.title", cond: filter_smart },
      teacher: { source: "Piece.teacher", cond: filter_smart },
      year: { source: "Piece.year", cond: filter_smart },
      kind: { source: "Piece.kind", cond: filter_smart },
      data: { source: "Piece.data", orderable: false },
      operation: { orderable: false },
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        title: record.title,
        teacher: record.teacher,
        year: record.year,
        kind: record.kind,
        data: link_to('Go', record.data),
        operation: link_to('delete', piece_path(record), method: :delete, data: { confirm: 'Are you sure?' })
      }
    end
  end

  private

  def get_raw_records
    Piece.all
  end

  def filter_smart
    ->(column) do
      ::Arel::Nodes::SqlLiteral.new(column.field.to_s).matches_any(
        column.search.value.split(/\s/).map { |s| "%#{s}%" }
      )
    end
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
