# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  Faker::Config.locale = 'en-CA'

  if Rails.env.production?

    Company.create(
      name: 'Get a grip studios',
      address1: '3800 Victoria Park Ave',
      city: "North York, Toronto",
      province: "Ontario",
      postal_code: "M2H 3H7",
      email: "producer@getagripstudios.com",
      phone: "416-492-5835",
      release: "I/we (including any corporations or entities I represent, work for or are otherwise affiliated with) hereby grant to the Client of Get a Grip on Studios and/or the LightED Online Video Show (hereafter \"the Podcast\") their subsidiaries, affiliates, agents, successors, and assigns the right and permission to record, use, publish, stream live, offer for sale, or otherwise distribute any audio or video interview with myself. Such right and permission includes, but is not limited to, my name, recorded voice or video, photograph or likeness, biographical information, corporate logos, corporate marketing material, logos, social media handles, handouts or any material based upon or derived therefrom.I understand that The Podcast may, at its sole discretion, produce presentations or publications based in whole or in part upon audio interview (or any portions thereof) and/or a video or audio recordings or photographs of said interview, and that such media or transcripts may appear in print, online, or in any manner or media, including but not limited to promoting the podcast or streaming audio program."
    )

    #USER ADMIN
    User.create(
      first_name: "Michael",
      last_name: "Colligan",
      email: "michael@mail.com",
      phone: "(416) 333 6554",
      role: "admin",
      signed_release: true,
      profile_done: true,
      password: "password",
      password_confirmation: "password"
    )

  end


  if Rails.env.development?
    #COMPANY
    Company.create(
      name: 'Get a grip studios',
      address1: '3800 Victoria Park Ave',
      city: "North York, Toronto",
      province: "Ontario",
      postal_code: "M2H 3H7",
      email: "producer@getagripstudios.com",
      phone: "416-492-5835",
      release: "I/we (including any corporations or entities I represent, work for or are otherwise affiliated with) hereby grant to the Client of Get a Grip on Studios and/or the LightED Online Video Show (hereafter \"the Podcast\") their subsidiaries, affiliates, agents, successors, and assigns the right and permission to record, use, publish, stream live, offer for sale, or otherwise distribute any audio or video interview with myself. Such right and permission includes, but is not limited to, my name, recorded voice or video, photograph or likeness, biographical information, corporate logos, corporate marketing material, logos, social media handles, handouts or any material based upon or derived therefrom.I understand that The Podcast may, at its sole discretion, produce presentations or publications based in whole or in part upon audio interview (or any portions thereof) and/or a video or audio recordings or photographs of said interview, and that such media or transcripts may appear in print, online, or in any manner or media, including but not limited to promoting the podcast or streaming audio program."
    )

    #USER ADMIN
    User.create(
      first_name: "Admin",
      last_name: "User",
      email: "admin@mail.com",
      phone: "(416) 000 0000",
      role: "admin",
      signed_release: true,
      profile_done: true,
      password: "password",
      password_confirmation: "password"
    )

    #FAKE USERS
    500.times do
      phone = "(#{Faker::PhoneNumber.area_code}) #{Faker::PhoneNumber.exchange_code} #{Faker::PhoneNumber.subscriber_number}"
      first_name = Faker::Name.unique.first_name
      User.create(
        first_name: first_name,
        last_name: Faker::Name.last_name,
        email: "#{first_name.downcase}@mail.com",
        phone: phone,
        password: "password",
        password_confirmation: "password"
      )
    end

  end
