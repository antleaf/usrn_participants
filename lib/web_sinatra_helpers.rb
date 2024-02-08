# frozen_string_literal: true

class USRNParticipantsApp < Sinatra::Base
  helpers do
    def process_text(text)
      text.gsub(/(\r\n|\n|\r)/, '<br />')
    end

    def humanise(text)
      text.to_s.gsub(/_/, ' ').capitalize
    end

    def missions(sr)
      [
        { value: sr.mission_keeping_track, name: 'Keep track of outputs' },
        { value: sr.mission_increase_discoverability, name: 'Increase discoverability' },
        { value: sr.mission_capture_metadata, name: 'Capture metadata' },
        { value: sr.mission_avoid_duplication, name: 'Avoid duplication' },
        { value: sr.mission_populate_pids, name: 'Populate PIDs' },
        { value: sr.mission_timely_oa, name: 'Timely OA' },
        { value: sr.mission_machine_accessible, name: 'Machine accessible' }
      ]
    end
  end
end