# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.production?
  
  Company.create(
    name: 'Get a grip studios',
    address1: '3800 Victoria Park Ave',
    city: "North York, Toronto",
    province: "Ontario",
    postal_code: "M2H 3H7",
    email: "producer@getagripstudios.com",
    phone: "416-492-5835",
    release: "<p dir=\"ltr\">We try to be super reasonable and have never distributed content that guests and clients did not want released. &nbsp;We have never denied a request to edit or bleep something out of a podcast or show and we have never refused to remove content when someone asked us to. &nbsp;But lets get a few things straight:&nbsp;</p><p dir=\"ltr\">I and You means you; the person who has set up the profile including any corporations or entities you have entered into your account. &nbsp;You are participating in an unrehearsed conversation with people you don’t know. &nbsp;They may offend you or say something you don’t like or find distasteful. &nbsp; We will be recording your voice, image and likeness while you are in a conversation with someone you may seriously disagree with. &nbsp;We are going to post what we record to the internet along with the images, pictures, logos and files you uploaded to your account. &nbsp;We will likely be linking this content to the social media accounts you listed in your profile. &nbsp;You are agreeing that you are cool with all this. &nbsp;&nbsp;</p><p dir=\"ltr\">See some finer print below:&nbsp;</p><ol><li dir=\"ltr\"><p dir=\"ltr\">Video Podcasting and Digital Video Creation. &nbsp;You are participating in a long form conversational podcast. &nbsp;It is an unrehearsed and all the video and audio will be recorded. &nbsp;You are 100% responsible for what you say. &nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">The Content Belongs to Us.&nbsp; You are being interviewed but just assume that as soon as you enter the studio (virtually or actually) everything is being recorded and belongs to us.</p></li><li dir=\"ltr\"><p dir=\"ltr\">The Content Can Be Deployed Anyway We Want.&nbsp; Everything that is recorded will be available to stream, view and download for anyone with an internet connection to consume. Remember, the internet is a big place and a permanent place. &nbsp;We may also edit it into clips for promotional purposes or to advertise our products and services on social media or anywhere else we want.&nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">Regrets.&nbsp; You may, at a future date, regret what you said and request that we remove video and audio files. &nbsp;We see no reason why we would deny your request but reserve our rights nonetheless and certainly make no guarantees that we will be able to do it. &nbsp;Remember, in the likely event that we acquiesce to a removal request you will have to accept that the files will have likely been downloaded and shared by strangers on the internet. &nbsp; Once it is released it can never be fully recovered. &nbsp;&nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">Editorial Control.&nbsp; We complete and total editorial control. &nbsp;You may ask us to remove something you say or bleep something out and we have never refused a guests request to do so. &nbsp;But again, we reserve our rights and insist that the content belongs to us. &nbsp;We also reserve our rights to the erring of the human species. &nbsp;If we choose to accept your revisions and upload a video or audio file with content you didn’t want in it, by accident, because of confusion or a mistake, we accept zero responsibility. &nbsp;In fact, you indemnify us and our associates, other clients, affiliates, agents, successors, hosts, co-hosts and assigns. &nbsp;All of the latter and hold us harmless and agree never to take legal or civil or any kind of action of any kind or manner against us.</p></li><li dir=\"ltr\"><p dir=\"ltr\">Discrimination.&nbsp; You revoke any and all Human Rights Claims. &nbsp;You are in a conversation. &nbsp;It is likely someone will disagree with you, offend you, say something you don’t like or take out of context and find offensive. &nbsp;You understand that this is the nature of what it is that you are participating in and the content created may not actually be as you perceived or thought it would be. &nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">Risks.&nbsp; Posting unrehearsed conversations on the internet is risky. &nbsp;You accept these risks to your reputation and good name. &nbsp;People might mis-interpret what you say or how you say it. &nbsp; It may come across the wrong way. &nbsp;We accept zero responsibility for risks to you or reputation. &nbsp; &nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">Who You Are Representing.&nbsp; If you represent some formal entity or corporation you have received the necessary permissions to bind the latter to the terms of this release.</p></li><li dir=\"ltr\"><p dir=\"ltr\">Indemnification and Legal Fees.&nbsp; If you choose to sue us or bring us before any court, tribunal, magistrate or otherwise you indemnify us and our associates, other clients, affiliates, agents, successors, hosts, co-hosts and assigns and hold us harmless. &nbsp;And Finally, you agree to pay our estimated legal fees in advance should you take any action whatsoever against for the content produced during your time in our studio. &nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">Just being real clause - this is what it is. &nbsp;Ispso facto.&nbsp;</p></li></ol>"
    )
    
    #USER ADMIN
      User.create(
        first_name: "Admin",
        last_name: "User",
        country: "Canada",
        state: "Ontario",
        city: "Toronto",
        dob: "1987-07-01",
        email: "admin@mail.com",
        phone: "(416) 000 0000",
        role: "admin",
        signed_release: true,
        profile_done: true,
        password: "password",
        password_confirmation: "password"
      )
      
    end
    
    
    if Rails.env.development?
      Faker::Config.locale = 'en-CA'
      #COMPANY
      Company.create(
        name: 'Get a grip studios',
        address1: '3800 Victoria Park Ave',
        city: "North York, Toronto",
        province: "Ontario",
      postal_code: "M2H 3H7",
      email: "producer@getagripstudios.com",
      phone: "416-492-5835",
      release: "<p dir=\"ltr\">We try to be super reasonable and have never distributed content that guests and clients did not want released. &nbsp;We have never denied a request to edit or bleep something out of a podcast or show and we have never refused to remove content when someone asked us to. &nbsp;But lets get a few things straight:&nbsp;</p><p dir=\"ltr\">I and You means you; the person who has set up the profile including any corporations or entities you have entered into your account. &nbsp;You are participating in an unrehearsed conversation with people you don’t know. &nbsp;They may offend you or say something you don’t like or find distasteful. &nbsp; We will be recording your voice, image and likeness while you are in a conversation with someone you may seriously disagree with. &nbsp;We are going to post what we record to the internet along with the images, pictures, logos and files you uploaded to your account. &nbsp;We will likely be linking this content to the social media accounts you listed in your profile. &nbsp;You are agreeing that you are cool with all this. &nbsp;&nbsp;</p><p dir=\"ltr\">See some finer print below:&nbsp;</p><ol><li dir=\"ltr\"><p dir=\"ltr\">Video Podcasting and Digital Video Creation. &nbsp;You are participating in a long form conversational podcast. &nbsp;It is an unrehearsed and all the video and audio will be recorded. &nbsp;You are 100% responsible for what you say. &nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">The Content Belongs to Us.&nbsp; You are being interviewed but just assume that as soon as you enter the studio (virtually or actually) everything is being recorded and belongs to us.</p></li><li dir=\"ltr\"><p dir=\"ltr\">The Content Can Be Deployed Anyway We Want.&nbsp; Everything that is recorded will be available to stream, view and download for anyone with an internet connection to consume. Remember, the internet is a big place and a permanent place. &nbsp;We may also edit it into clips for promotional purposes or to advertise our products and services on social media or anywhere else we want.&nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">Regrets.&nbsp; You may, at a future date, regret what you said and request that we remove video and audio files. &nbsp;We see no reason why we would deny your request but reserve our rights nonetheless and certainly make no guarantees that we will be able to do it. &nbsp;Remember, in the likely event that we acquiesce to a removal request you will have to accept that the files will have likely been downloaded and shared by strangers on the internet. &nbsp; Once it is released it can never be fully recovered. &nbsp;&nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">Editorial Control.&nbsp; We complete and total editorial control. &nbsp;You may ask us to remove something you say or bleep something out and we have never refused a guests request to do so. &nbsp;But again, we reserve our rights and insist that the content belongs to us. &nbsp;We also reserve our rights to the erring of the human species. &nbsp;If we choose to accept your revisions and upload a video or audio file with content you didn’t want in it, by accident, because of confusion or a mistake, we accept zero responsibility. &nbsp;In fact, you indemnify us and our associates, other clients, affiliates, agents, successors, hosts, co-hosts and assigns. &nbsp;All of the latter and hold us harmless and agree never to take legal or civil or any kind of action of any kind or manner against us.</p></li><li dir=\"ltr\"><p dir=\"ltr\">Discrimination.&nbsp; You revoke any and all Human Rights Claims. &nbsp;You are in a conversation. &nbsp;It is likely someone will disagree with you, offend you, say something you don’t like or take out of context and find offensive. &nbsp;You understand that this is the nature of what it is that you are participating in and the content created may not actually be as you perceived or thought it would be. &nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">Risks.&nbsp; Posting unrehearsed conversations on the internet is risky. &nbsp;You accept these risks to your reputation and good name. &nbsp;People might mis-interpret what you say or how you say it. &nbsp; It may come across the wrong way. &nbsp;We accept zero responsibility for risks to you or reputation. &nbsp; &nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">Who You Are Representing.&nbsp; If you represent some formal entity or corporation you have received the necessary permissions to bind the latter to the terms of this release.</p></li><li dir=\"ltr\"><p dir=\"ltr\">Indemnification and Legal Fees.&nbsp; If you choose to sue us or bring us before any court, tribunal, magistrate or otherwise you indemnify us and our associates, other clients, affiliates, agents, successors, hosts, co-hosts and assigns and hold us harmless. &nbsp;And Finally, you agree to pay our estimated legal fees in advance should you take any action whatsoever against for the content produced during your time in our studio. &nbsp;</p></li><li dir=\"ltr\"><p dir=\"ltr\">Just being real clause - this is what it is. &nbsp;Ispso facto.&nbsp;</p></li></ol>"
    )

    #USER ADMIN
    User.create(
      first_name: "Admin",
      last_name: "User",
      country: "Canada",
      state: "Ontario",
      city: "Toronto",
      dob: "1987-07-01",
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
        # first_name: first_name,
        # last_name: Faker::Name.last_name,
        # dob: Faker::Date.birthday(18, 65),
        email: "#{first_name.downcase}@mail.com",
        phone: phone,
        password: "password",
        password_confirmation: "password"
      )
    end

  end
