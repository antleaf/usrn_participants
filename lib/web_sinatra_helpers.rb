# frozen_string_literal: true

class USRNParticipantsApp < Sinatra::Base
  helpers do
    def process_text(text)
      text.gsub(/(\r\n|\n|\r)/, '<br />')
    end

    def humanise(text)
      text.to_s.gsub(/_/, ' ').capitalize
    end

    def dehumanise(text)
      text.gsub(/[\s-]/,'_').downcase
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

    def technologies(sr)
      [
        { value: sr.technologies_oai_pmh, name: 'OAI-PMH' },
        { value: sr.technologies_rioxx, name: 'Rioxx' },
        { value: sr.technologies_openaire_guidelines, name: 'OpenAIRE Guidelines' },
        { value: sr.technologies_signposting, name: 'Signposting' },
        { value: sr.technologies_resourcesync, name: 'ResourceSync' },
        { value: sr.technologies_coar_notify, name: 'COAR Notify' },
        { value: sr.technologies_coar_vocabularies, name: 'COAR Vocabularies' },
        { value: sr.technologies_jav, name: 'JAV' },
        { value: sr.technologies_credit, name: 'CRediT' },
        { value: sr.technologies_counter, name: 'COUNTER' },
        { value: sr.technologies_fairicat, name: 'FAIRICat' }
      ]
    end
  end
end