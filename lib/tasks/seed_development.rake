if Rails.env.development? || Rails.env.test?
  namespace :dev do
    desc "Sample data for local development environment"
    task prime: "db:setup" do
      puts 'Destroying old records...'
      Transfer.destroy_all
      MaterialType.destroy_all
      Material.destroy_all
      Address.destroy_all
      puts 'Creating users...'
      7.times do |i|
        participants = []
        url = 'https://picsum.photos/200'
        if i == 1
          6.times do |j|
            filename = File.basename(URI.parse(url).path)
            user = User.new(
              email: "participant_#{j}@cannabishouse.eu",
              password: '1111222233334444',
              password_confirmation: '1111222233334444',
              agreement_1: true,
              agreement_2: true)
            user.skip_confirmation!
            user.save!
            file = URI.open(url)
            user.profile.avatar.attach(io: file, filename: filename, content_type: "image/jpg")
            user.profile.update(
              role: 'participant',
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              gender: rand(0..1),
              contact_number: Faker::PhoneNumber.phone_number,
              pesel: '19293012949')
            user.profile.onboarded = true unless i.zero?
            user.profile.verified = true unless i.zero?
            user.profile.credits = 10_000_000 if i == 1
            user.profile.save
            participants << user
            puts "created #{user.profile.first_name}:#{user.id} with role #{user.profile.role}"
            user.profile.update!(
            role: 'participant',
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            gender: rand(0..1),
            contact_number: Faker::PhoneNumber.phone_number,
            pesel: '19293012949',
            risk_calculated: 'orange')
            user.profile.onboarded = true unless i.zero?
            user.profile.verified = true unless i.zero?
            user.profile.credits = 10_000_000 if i == 1
            user.profile.save
            puts "created #{user.profile.first_name}:#{user.id} with role #{user.profile.role}"
          end
        else
          filename = File.basename(URI.parse('https://picsum.photos/200').path)
          user = User.new(
            email: "#{%w[user participant dispensary doctor researcher warehouse admin][i]}@cannabishouse.eu",
            password: '1111222233334444',
            password_confirmation: '1111222233334444',
            agreement_1: true,
            agreement_2: true)
          user.skip_confirmation!
          user.save!
          file = URI.open(url)
          user.profile.avatar.attach(io: file, filename: filename, content_type: "image/jpg") if file
          user.profile.update(
          role: %w[user participant dispensary doctor researcher warehouse admin][i],
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          gender: rand(0..1),
          contact_number: Faker::PhoneNumber.phone_number,
          pesel: '19293012949')
          user.profile.onboarded = true unless i.zero?
          user.profile.verified = true unless i.zero?
          user.profile.credits = 10_000_000 if i == 1
          user.profile.save
          puts "created #{user.profile.first_name}:#{user.id} with role #{user.profile.role}"
        end
      end
      puts 'Generating fake appointment slots...'
      12.times do
        time = DateTime.now.utc.change({ hour: rand(8..20), min: ['00', '30'][rand(0..1)].to_i })
        Slot.create(day: rand(0..6), time: time, doctor: Profile.find_by(role: 'doctor').user)
      end

      puts 'Generating fake appointments...'
      participants = Profile.where(role: 'participant')
      6.times do |i|
        s = Slot.find(rand(1..10))

        # Next three lines are to convert Day of Week to Day of Month
        temp = Date.parse(s.time.strftime('%A'))
        delta = temp > Date.today ? 0 : 7
        day = (temp + delta).day

        time = DateTime.new(2021, 7, day, s.hours, s.minutes)
        a = Appointment.create(doctor: Profile.find_by(role: 'doctor').user, participant: participants[i].user, time: time)
        participants[i].book!
        a.update(state: 'done') if i.odd?
        a.participant.profile.set_quota(30, 20, 'orange', true) if i == 1
        a.update!(state: 'evaluated') if i == 1
      end

      puts 'Creating MaterialTypes'
      3.times do |i|
        MaterialType.create(name: %w[Sativa Indica Hybrid Oil][i])
      end

      puts 'Creating Material'
      10.times do |i|
        material = Material.create(
          material_type: MaterialType.all.sample,
          name: Faker::Cannabis.strain,
          description: "Description #{i}",
          weight: 1000,
          thc: rand(0..40),
          cbd: rand(0..40),
          terpene: rand(0..40),
          drought: !(i % 5).zero?,
          oil: (i % 5).zero?,
          edible: (i % 5).zero?,
          cost: (i % 5).zero? ? 12_000 : 4000,
          owner_id: Profile.find_by(role: 'warehouse').user_id)
        material.save!
        puts "Created #{material.name} ##{material.id}"
      end

      puts 'Transferring Material from Warehouse to Dispensary'
      Material.all.each do |material|
        transfer = material.split(Profile.find_by(role: 'dispensary').user, 1000)
        if transfer[0]
          puts "Transferred #{transfer[1].weight} grams of #{material.name} to dispensary"
        else
          puts "Could not transfer #{material.name}, message: #{transfer[1]}"
        end
      end

      puts 'Transferring Material from Dispensary to Participant'
      Material.where(owner_id: Profile.find_by(role: 'dispensary').user).each do |material|
        transfer = material.split(Profile.find_by(aasm_state: 'approved').user, 30)
        if transfer[0]
          puts "Transferred #{transfer[1].weight} grams of #{material.name} to participant"
        else
          puts "Could not transfer #{material.name}, message: #{transfer[1]}"
        end
      end
      
      puts 'Creating Studies'
      puts 'Creating Dummy Study'
      study = Study.create(title: 'dummy Study', description: 'Just to test out the views', cycle: 4, max: 10, user_id: Profile.find_by(role: 'researcher').user.id)


      puts 'Creating dummy survey'
      survey = Survey.create(title: 'Dummy Survey', description: 'Trying out the views', internal_name: 'dummy', required: false, user_id: Profile.find_by(role: 'researcher').user.id, study: study)
    end
  end
end
