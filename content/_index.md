---
date: "2022-10-24"
sections:
# - block: hero
#   content:
#     cta:
#       label: '**Get Started**'
#       url: https://wowchemy.com/templates/
#     cta_alt:
#       label: Ask a question
#       url: https://discord.gg/z8wNYzb
#     cta_note:
#       label: '<div style="text-shadow: none;"><a class="github-button" href="https://github.com/wowchemy/wowchemy-hugo-themes"
#         data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star">Star
#         Wowchemy Website Builder</a></div><div style="text-shadow: none;"><a class="github-button"
#         href="https://github.com/wowchemy/starter-hugo-academic" data-icon="octicon-star"
#         data-size="large" data-show-count="true" aria-label="Star">Star the Academic
#         template</a></div>'
#     image:
#       filename: hero-academic.png
#     text: |-
#       **Generated by Wowchemy - the FREE, Hugo-based open source website builder trusted by 500,000+ sites.**
# 
#       **Easily build anything with blocks - no-code required!**
# 
#       From landing pages, second brains, and courses to academic resumés, conferences, and tech blogs.
# 
#       <!--Custom spacing-->
#       <div class="mb-3"></div>
#       <!--GitHub Button JS-->
#       <script async defer src="https://buttons.github.io/buttons.js"></script>
#     title: Hugo Academic Theme
#   design:
#     background:
#       gradient_end: '#1976d2'
#       gradient_start: '#004ba0'
#       text_color_light: true
- block: about.avatar
  content:
    text: null
    username: admin
  id: about

- block: features
  content:
    items:
    - description: '*advanced*'
      icon: r-project-icon
      icon_pack: custom
      name: R
    - description: '*basic*'
      icon: python-icon
      icon_pack: custom
      name: Python
    - description: '*basic*'
      icon: stata
      icon_pack: custom
      name: Stata
    - description: '*intermediate*'
      icon: ArcGIS_Pro
      icon_pack: custom
      name: ArcGIS Pro
    - description: '*intermediate/advanced*'
      icon: microsoft_vb-icon
      icon_pack: custom
      name: VBA/Excel
    - description: '*intermediate*'
      icon: overleaf-o-logo-primary
      icon_pack: custom
      name: LaTeX
    title: Programming Skills
    
- block: education
  content:
    title: Education
    date_format: Jan 2006
    items:
    - company: University of Sao Paulo (USP)
      company_logo: org-usp
      company_url: ""
      date_end: "2025-03-06"
      date_start: "2020-01-01"
      description: |2-
      
          - "Essays on Fiscal Decentralization and Public Finance"
          - Advisor: Prof. Sergio Naruhiko Sakurai
          
      location: Ribeirao Preto, Brazil
      title: Ph.D. in Economics
    - company: Carnegie Mellon University (CMU)
      company_logo: org-cmu
      company_url: ""
      date_end: "2024-06-30"
      date_start: "2023-07-01"
      description: |2-
      
          - "Impact of Natural Disasters on Local Public Finance"
          - Co-Advisors:
            - Prof. Sergio Naruhiko Sakurai
            - Prof. Edson Severnini
          
      location: Pittsburgh, USA
      title: Sandwich Doctorate Abroad
    - company: Getulio Vargas Foundation (FGV)
      company_logo: org-fgv
      company_url: ""
      date_end: "2019-02-01"
      date_start: "2017-08-01"
      # description: Taught electronic engineering and researched semiconductor physics.
      location: Sao Paulo, Brazil
      title: Specialization in Economics and Management
    - company: University of Sao Paulo (USP)
      company_logo: org-usp
      company_url: ""
      date_end: "2014-12-31"
      date_start: "2010-03-01"
      # description: |2-
      location: Sao Paulo, Brazil
      title: B.Sc. in Business Administration
    - company: Jonkoping University (JU)
      company_logo: org-ju
      company_url: ""
      date_end: "2013-12-10"
      date_start: "2013-08-10"
      # description: Taught electronic engineering and researched semiconductor physics.
      location: Sao Paulo, Brazil
      title: Academic Exchange Program
    title: Education
  design:
    columns: "2"
    
- block: experience
  content:
    title: Experience
    date_format: Jan 2006
    items:
    - company: Foundation for the Development of Legal Education and Research (FADEP)
      company_logo: org-fadep
      company_url: "https://fadeprp.org.br/"
      date_end: "2021-05-30"
      date_start: "2021-03-01"
      description: Conducted a technical and financial feasibility study of the proposed Administrative Reform for the Municipality of Ribeirão Preto, assessing its budgetary impacts.
      location: Ribeirao Preto, Brazil
      title: Financial Consultant
    - company: Legislative Assembly of Sao Paulo (Alesp)
      company_logo: org-alesp
      company_url: "https://www.al.sp.gov.br/"
      date_end: "2020-01-06"
      date_start: "2019-03-01"
      description: Conducted studies on bills to support the state deputy votes.
      location: Sao Paulo, Brazil
      title: Legislative Assistant
    - company: Municipal Government of Sao Paulo
      company_logo: org-pmsp
      company_url: "https://www.capital.sp.gov.br/"
      date_end: "2021-09-01"
      date_start: "2021-01-05"
      description: Joined the team coordinating 22 municipal departments to develop Sao Paulo’s strategic plan (2017-2020) for the newly elected mayor.
      location: Sao Paulo, Brazil
      title: Management and Planning Assistant
    - company: Sonne Consulting
      company_logo: org-sonne
      company_url: "https://www.sonne.global/"
      date_end: "2016-12-01"
      date_start: "2012-03-01"
      description: Conducted business diagnostics and market research to provide insights for strategic and marketing planning of small and medium-sized companies in the education, hospitality, and staffing industries.
      location: Sao Paulo, Brazil
      title: Market and Business Intelligence Analyst
    - company: Itaú BBA
      company_logo: org-itaubba
      company_url: "https://www.itau.com.br/itaubba-en/international"
      date_end: "2013-08-01"
      date_start: "2012-03-01"
      description: Performed accounting reconciliations for financial operations with external agencies and supported back-office operations for the initial loan and FX products at the Colombian branch.
      location: Sao Paulo, Brazil
      title: Controlling and Accounting Intern
    title: Professional Experience
  design:
    columns: "2"
    
# - block: accomplishments
#   content:
#     date_format: Jan 2006
#     items:
#     - certificate_url: https://www.coursera.org
#       date_end: ""
#       date_start: "2021-01-25"
#       description: ""
#       organization: Coursera
#       organization_url: https://www.coursera.org
#       title: Neural Networks and Deep Learning
#       url: ""
#     - certificate_url: https://www.udemy.com
#       date_end: ""
#       date_start: "2021-01-01"
#       description: Formulated informed blockchain models, hypotheses, and use cases.
#       organization: edx
#       organization_url: https://www.udemy.com
#       title: Blockchain Fundamentals
#       url: https://www.edx.org/professional-certificate/uc-berkeleyx-blockchain-fundamentals
#     - certificate_url: https://www.datacamp.com
#       date_end: "2020-12-21"
#       date_start: "2020-07-01"
#       description: ""
#       organization: DataCamp
#       organization_url: https://www.datacamp.com
#       title: Object-Oriented Programming in R
#       url: ""
#     subtitle: null
#     title: Accomplishments
#   design:
#     columns: "2"
    
# - block: collection
#   content:
#     count: 5
#     filters:
#       author: ""
#       category: ""
#       exclude_featured: false
#       exclude_future: false
#       exclude_past: false
#       folders:
#       - post
#       publication_type: ""
#       tag: ""
#     offset: 0
#     order: desc
#     subtitle: ""
#     text: ""
#     title: Recent Posts
#   design:
#     columns: "2"
#     view: compact
#   id: posts
  
# - block: markdown
#   content:
#     subtitle: ""
#     text: '{{< gallery album="demo" >}}'
#     title: Gallery
#   design:
#     columns: "1"

- block: collection
  content:
    filters:
      featured_only: true
      folders:
      - publication
    title: Featured paper
  design:
    columns: "2"
    view: card
  id: featured
  
- block: collection
  content:
    filters:
      exclude_featured: true
      folders:
      - publication
    # text: |-
    #   {{% callout note %}}
    #   [Filter papers](./publication/).
    #   {{% /callout %}}
    title: Research
  design:
    columns: "2"
    view: citation
    
  
- block: portfolio
  content:
    date_format: Jan 2006
    buttons:
    - name: All
      tag: '*'
    - name: Graduate
      tag: Graduate
    - name: Undergraduate
      tag: Undergraduate
    default_button_index: 0
    filters:
      folders:
      - project
    title: Teaching Assistance
    subtitle: (in Portuguese)
  design:
    columns: "2"
    flip_alt_rows: false
    view: 6
  id: projects
    
# - block: collection
#   content:
#     filters:
#       folders:
#       - event
#     title: Recent & Upcoming Talks
#   design:
#     columns: "2"
#     view: compact
#   id: talks
# - block: tag_cloud
#   content:
#     title: Popular Topics
#   design:
#     columns: "2"

- block: contact
  content:
    address:
      city: Sao Paulo
      country: Brazil
      country_code: US
    # postcode: "15213"
      region: Brazil
    # street: Vila Mariana
    # appointment_url: https://calendly.com
    autolink: true
    contact_links:
    # - icon: twitter
    #   icon_pack: fab
    #   link: https://twitter.com/Twitter
    #   name: DM Me
    # - icon: skype
    #   icon_pack: fab
    #   link: skype:echo123?call
    #   name: Skype Me
    # - icon: video
    #   icon_pack: fas
    #   link: https://zoom.com
    #   name: Zoom Me
    # directions: Enter Building 1 and take the stairs to Office 200 on Floor 2
    email: fhnishida@gmail.com
    # form:
    #   formspree:
    #     id: null
    #   netlify:
    #     captcha: false
    #   provider: netlify
    # office_hours:
    # - Monday 10:00 to 13:00
    # - Wednesday 09:00 to 11:00
    # phone: 888 888 88 88
    subtitle: null
    text: #Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam mi diam, venenatis ut magna et, vehicula efficitur enim.
    title: Contact
  design:
    columns: "2"
  id: contact
title: null
type: landing
---
