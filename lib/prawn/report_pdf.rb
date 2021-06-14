module Prawn
  class ReportPdf < Prawn::Document
    def initialize(transfers)
      super()
      @transfers = transfers
      header
      text_content
      table_content
    end

    def header
      #This inserts an image in the pdf file and sets the size of the image
      image "#{Rails.root}/app/assets/images/logo.png", width: 100, height: 50
    end

    def text_content
      # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
      y_position = cursor - 50

      # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
      bounding_box([0, y_position], :width => 270, :height => 50) do
        text "#{I18n.t('.magazine.address')}", size: 15, style: :bold
        text "Dispensary Address"
      end

      bounding_box([300, y_position], :width => 270, :height => 50) do
        text "Oznaczenie Dyspensarium", size: 15, style: :bold
        text "ZDW-1"
      end
    end

    def table_content
      table(data_set, :header => true)
    end
    def data_set
      cell_sender =
      i = 0
      data = [[
        'LP.',
        'rodzaj operacji magazynowej', 
        'data zdarzenia', 
        'nr dok operacji', 
        'Imie i nazwisko wydajacego', 
        'signature', 
        'imie i nazwisko odbiorcy', 
        'rodzaj srodka lub produktu', 
        'nr serii',
        'ilosc szt/g', 
        'stan po operacji'
        ]]
      data += @transfers.map do |transfer, i|
        [i, "wydanie", "#{transfer.updated_at}", transfer.id, Profile.find_by(user_id: transfer.sender_id).first_name.force_encoding("Windows-1252"), 'podpis', Profile.find_by(user_id: transfer.reciever_id).first_name.force_encoding("Windows-1252"), 'rodzaj materialu', 'nr serii', transfer.weight, 'zostalo']
      end
    end
  end
end