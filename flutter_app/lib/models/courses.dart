import 'package:flutter/material.dart';

final courses = <Map<String, dynamic>>[
  {
    'course_id': 1001,
    'course_name': "Pottery",
    'description':
        "    This course offers a thorough, well-organized, and detailed "
            "approach to the numerous aspects of the of the potter's "
            "wheel as a mode of artistic expression.  The class moves "
            "through studio set up and safety, construction processes, "
            "to artistic aesthetic choices. \n    The class is a thoughtful "
            "blend of artistic guidance and fundamental educational goals"
            " for art students, Wheel-Thrown Pottery for Beginners was "
            "developed for varying levels of art courses and for "
            "individuals wishing to pursue their own ceramic education. "
            "The class will enable you to speak knowledgeably about the "
            "medium, understand techniques, outline clear forming steps,"
            " and to expand your knowledge of the pottery’s wheel.",
    'course_content': [
      "Introduction to Clay and the Pottery Wheel",
      "Throwing Basics",
      "Cups",
      "Bowls and Open Forms",
      "Plates, Flatware and Bats",
      "Additional Skill Builders",
    ],
    'perks': [
      "Creative outlet",
      "Improved focus and concentration",
      "Increased mindfulness",
      "Improved hand-eye coordination",
      "Social Opportunities",
      "Sense of accomplishment",
      "Practical skills"
    ],
    'image_path': "Course_Images/Pottery.png",
    'color': Colors.redAccent.shade400
  },
  {
    'course_id': 1002,
    'course_name': "Knitting",
    'description': "This knitting course is designed for beginners who have"
        "little or no experience with knitting. The course will cover basic knitting techniques,"
        "terminology, and tools. You will learn how to cast on, knit, purl, increase, decrease,"
        "bind off, and read a pattern. By the end of the course, you will have the skills"
        " and confidence to tackle simple knitting projects on your own.",
    'course_content': [
      "Introduction to Knitting",
      "Getting Started",
      "Knitting Techniques",
      "Reading Knitting patterns",
      "Simple Knitting patterns",
    ],
    'perks': [
      "Creative outlet",
      "Stress Relief",
      "Mindfulness",
      "Building a Community",
      "Allows you to produce practical accessories"
    ],
    'image_path': "Course_Images/knitting.png",
    'color': Colors.amberAccent.shade400
  },
  {
    'course_id': 1003,
    'course_name': "Sewing",
    'description': "This sewing course is suitable for beginners who have little or no"
        "experience in sewing. The course will cover the basics of using a sewing machine,"
        "reading patterns, cutting and measuring fabrics, and sewing techniques. By the end of"
        "the course, students will have the skills to create their own garments and accessories.",
    'course_content': [
      "Introduction to sewing machines and equipment",
      "Understanding fabric types and their properties",
      "Measuring and cutting fabrics",
      "Sewing techniques including hemming, seaming, and inserting zippers",
      "Reading and understanding patterns",
      "Making simple garments and accessories",
      "Finishing techniques such as pressing and ironing"
    ],
    'perks': [
      "Learn a valuable skill that can be used for personal or professional purposes",
      "The ability to create your own clothing and accessories",
      "A fun and creative way to express your personal style",
      "“The potential to save money by creating your own garments and home decor items",
      "Opportunities to connect with a community of sewing enthusiasts through online groups or in-person classes",
      "Gain a sense of accomplishment and pride in creating something from scratch",
      "The potential to save money by creating your own garments and home decor items",
      "Opportunities to connect with a community of sewing enthusiasts through online",
      "groups or in-person classes",
      "Gain a sense of accomplishment and pride in creating something from scratch."
    ],
    'image_path': "Course_Images/Sewing.png",
    'color': Colors.blueGrey.shade600
  },
  {
    'course_id': 1004,
    'course_name': "Fishing",
    'description':
        "     The fishing course is designed to provide individuals with the necessary knowledge and skills to become proficient anglers."
            "This course is ideal for beginners who are interested in learning the basics of fishing, as well as for experienced anglers who want to"
            "o improve their techniques and increase their chances of catching fish.",
    'course_content': [
      " Introduction to fishing: This section covers the basics of fishing, including the different types of fishing equipment, fishing knots, and fishing terminology.",
      "Fish identification: In this section, you will learn how to identify different types of fish, their habits, and their habitats.",
      "Bait selection and presentation: This section covers the different types of bait that can be used for different types of fish and how to present them to increase the chances of catching fish.",
      "Casting techniques: This section covers different casting techniques, including the overhead cast, sidearm cast, and roll cast.",
      "Fishing regulations and ethics: This section covers the laws and regulations related to fishing, as well as ethical considerations when fishing.",
      "Fishing safety: This section covers the safety precautions that should be taken while fishing, including the use of life jackets, proper handling of fish, and first aid techniques.",
    ],
    'perks': [
      "Improved success rate: By learning the basics of fishing, identifying different types of fish, and mastering casting techniques, individuals will increase their chances of catching fish.",
      "Cost-effective: Taking a fishing course can be a cost-effective way to learn the basics of fishing compared to hiring a guide or learning through trial and error",
      "Social activity: Fishing can be a great social activity, and taking a course can be a great way to meet new people who share similar interests.",
      "Outdoor activity: Fishing is a great way to enjoy the outdoors and experience nature. Taking a course can help individuals develop a deeper appreciation for the natural environment.",
    ],
    'image_path': "Course_Images/Fishing.png",
    'color': Colors.tealAccent.shade400
  },
  {
    'course_id': 1005,
    'course_name': "Crafting",
    'description':
        "    TThis course is designed for individuals who enjoy crafting and want to learn how to create their own gift bags and photo frames. "
            " Participants will be taught the techniques and skills needed to create unique and personalized gift bags and photo frames for any occasion."
            " They will also learn how to use different materials and tools to create beautiful designs that will impress their friends and family.",
    'course_content': [
      "Introduction to crafting gift bags and photo frames",
      "Materials and tools needed for crafting",
      "Techniques for creating different types of gift bags and photo frames",
      "Personalization and customization of designs",
      "Embellishment and decoration techniques",
      "Tips and tricks for successful crafting",
    ],
    'perks': [
      "Opportunity to learn new crafting skills",
      " Ability to create personalized and unique gift bags and photo frames",
      "Access to expert instruction and guidance",
      "Opportunity to socialize and meet new people who share a passion for crafting",
      "All materials and tools provided",
      "Ability to take home the finished products and use them for gifts or personal use",
      "A fun and engaging learning experience",
    ],
    'image_path': "Course_Images/Crafting.png",
    'color': Colors.redAccent.shade400
  },
  {
    'course_id': 1006,
    'course_name': "Hand looming",
    'description':
        "    The hand looming course is designed to teach students the art of weaving fabrics by hand, using traditional techniques and equipment."
            "Students will learn about the history and cultural significance of hand looming, as well as the different types of looms and weaving techniques."
            "They will also learn how to prepare the loom, choose the right yarns, and create a variety of different patterns and designs.",
    'course_content': [
      "Introduction to hand looming: This section provides an overview of the history and cultural significance of hand looming.",
      "Types of looms: Students will learn about the different types of looms used in hand looming, including floor looms, table looms, and lap looms.",
      "Setting up the loom: This section covers the steps required to set up the loom, including preparing the warp and the weft, and adjusting the tension.",
      "Choosing yarns: Students will learn about different types of yarns and how to choose the right yarn for their project.",
      "Basic weaving techniques: This section covers the basic weaving techniques used in hand looming, including tabby weave, twill weave, and satin weave.",
      "Pattern and design: Students will learn how to create patterns and designs using different weaving techniques and yarns.",
      "Finishing techniques: This section covers the different finishing techniques used to complete a hand loomed project, including washing, blocking, and hemming.",
    ],
    'perks': [
      "Creativity: Handlooming allows students to express their creativity by designing and creating their own unique fabrics.",
      "Traditional craft: Hand looming is a traditional craft that has been practiced for thousands of years, and learning this skill can be a fulfilling way to connect with history and culture.",
      "Sustainability: Handlooming is a sustainable alternative to mass-produced textiles, as it does not require the use of large machines or harmful chemicals.",
      "Therapeutic: Weaving can be a therapeutic and relaxing activity, providing a sense of accomplishment and reducing stress and anxiety.",
      "Career opportunities: Learning hand looming can lead to career opportunities in the fashion industry, textile design, or as an independent artisan selling their own handmade creations.",
    ],
    'image_path': "Course_Images/Hand_looming.png",
    'color': Colors.redAccent.shade400
  },
  {
    'course_id': 1007,
    'course_name': "Carpet Making",
    'description':
        "    “ The carpet making course is a comprehensive program designed to teach students the art of carpet making."
            "The course covers everything from the basics of materials and tools to the more advanced techniques of pattern making and dyeing."
            "Students will learn to create a variety of carpet styles, including traditional and modern designs.",
    'course_content': [
      "Introduction to Carpet Making: This module provides an overview of the course and introduces students to the basics of carpet making",
      "Materials and Tools: In this module, students will learn about the different materials and tools used in carpet making, including yarns, dyes, looms, and other equipment.",
      "Basic Techniques: This module covers the basic techniques used in carpet making, such as knotting, weaving, and embroidery.",
      " Pattern Making: Students will learn how to create patterns for their carpets, including traditional and modern designs.",
      " Dyeing: This module covers the different techniques used in dyeing yarns for carpets, including natural and synthetic dyes.",
      " Finishing Techniques: In this module, students will learn how to finish their carpets, including trimming, fringing, and backing.",
    ],
    'perks': [
      "Hands-On Experience: The carpet making course is typically a hands-on experience, giving students the opportunity to practice their skills and create their own carpets.",
      "Creative Expression: Carpet making is an art form that allows for a great deal of creative expression, and students will have the opportunity to explore their own ideas and designs.",
      "Career Opportunities: For those interested in pursuing a career in the carpet making industry, the course provides a solid foundation in the skills and techniques needed to succeed.",
      "Social Connection: Carpets making courses often bring people with common interests together, so students have the opportunity to connect with others who share their passion.",
      "Personal Satisfaction: Creating a carpet from start to finish can be a rewarding experience, and students will have a tangible product that they can be proud of for years to come.",
    ],
    'image_path': "Course_Images/Carpet_making.png",
    'color': Colors.redAccent.shade400
  },
  {
    'course_id': 1008,
    'course_name': "Silk Reeling & Spinning",
    'description':
        "    “ In a typical silk reeling and spinning course, students will learn how to handle raw silk fibers, clean and prepare them for spinning, and then use a spinning wheel or spindle to create the thread or yarn."
            "The course will cover the entire process from start to finish.",
    'course_content': [
      "The history and cultural significance of silk reeling and spinning",
      "The biology of silk moths and silk cocoons",
      "How to prepare silk cocoons for reeling",
      "How to reel silk thread from a cocoon",
      "Different types of spinning wheels and spindles and how to use them",
      "How to create a consistent and even thread or yarn",
      "How to ply silk yarn",
      "Dyeing silk yarn with natural dyes",
      "Troubleshooting common spinning problems",
    ],
    'perks': [
      "Learning a traditional craft and gaining a new skill",
      "Creating beautiful, handmade silk thread or yarn that can be used for textile arts",
      "Relaxation and stress relief through the meditative process of spinning",
      "Meeting other like-minded crafters and building a sense of community",
      "Connecting with history and cultural traditions",
      "Opportunities for further exploration of textile arts, such as knitting or weaving.",
    ],
    'image_path': "Course_Images/Silk_Reeling_And_Spinning.png",
    'color': Colors.redAccent.shade400
  },
  {
    'course_id': 1009,
    'course_name': "Modern Farm Handling Equipments",
    'description':
        "    The modern farming handling equipment course is designed to provide students with the knowledge and skills needed to safely and effectively operate a range of equipment commonly used in modern agriculture."
            "The course covers topics such as equipment selection, maintenance, and repair, as well as safe operating procedures and regulations."
            "Students will gain hands-on experience operating and maintaining equipment such as tractors, combines, sprayers, and more.",
    'course_content': [
      "Introduction to modern farming handling equipment",
      "Equipment selection and purchasing",
      "Equipment maintenance and repair",
      "Safe operating procedures and regulations",
      "Tractor operation and maintenance",
      "Combine operation and maintenance",
      "Sprayer operation and maintenance",
      "Irrigation system operation and maintenance",
      "Precision agriculture technology",
      "Harvesting and post-harvest handling",
    ],
    'perks': [
      "Hands-on experience with modern farming handling equipment",
      "Ability to operate and maintain a variety of agricultural equipment",
      "Knowledge of safe operating procedures and regulations",
      "Improved efficiency and productivity in farming operations",
      "Enhanced career opportunities in agriculture and related fields.",
    ],
    'image_path': "Course_Images/Modern_Farming.png",
    'color': Colors.redAccent.shade400
  },
  {
    'course_id': 1010,
    'course_name': "Organic Farming",
    'description':
        "   “ Organic farming is a sustainable agricultural system that prioritizes the use of natural and environmentally friendly farming practices."
            " In this course, students will learn the principles and techniques of organic farming, including soil management, crop rotation, pest and disease control, composting, and marketing strategies."
            " The course will cover both the theoretical and practical aspects of organic farming.",
    'course_content': [
      "Introduction to organic farming principles and practices",
      "Soil management and fertility",
      "Crop rotation and intercropping",
      "Organic pest and disease control methods",
      "Composting and other organic waste management techniques",
      "Organic livestock management",
      "Certification and regulation of organic farming",
      "Marketing strategies for organic produce",
      "Sustainable agriculture and agroecology",
    ],
    'perks': [
      "Increased knowledge and skills in organic farming techniques and practices.",
      "Opportunities to network with other organic farmers and industry professionals.",
      "The ability to apply for organic farming certification.",
      "Enhanced marketability as an organic farmer or farm manager.",
      "The ability to contribute to sustainable agriculture and environmental conservation efforts.",
    ],
    'image_path': "Course_Images/Organic_Farming.png",
    'color': Colors.redAccent.shade400
  },
  {
    'course_id': 1011,
    'course_name': "Crop protection",
    'description':
        "   This course is designed to provide students with a comprehensive understanding of the principles and practices of crop protection. "
            "The course will cover the various pests and diseases that affect crops, including their identification, biology, and control."
            "Students will learn about the latest tools and techniques used to protect crops, including the use of chemicals, biological controls, and cultural practices.",
    'course_content': [
      "Introduction to crop protection",
      "Principles of plant pathology",
      "Principles of entomology",
      "Principles of weed science",
      "Agronomy and crop management practices",
      "Chemical control methods",
      "Biological control methods",
      "Cultural control methods",
      "Integrated pest management (IPM)",
      "Environmental and health aspects of crop protection",
    ],
    'perks': [
      "Increased knowledge and skills in crop protection techniques and methods",
      "Opportunities to network with professionals in the industry",
      "Access to the latest research and developments in crop protection",
      "Improved job prospects in the agricultural industry",
      "Potential for increased earnings in the agricultural industry",
      "Opportunities for continued education and professional development in the field of crop protection.",
    ],
    'image_path': "Course_Images/Crop_protection.png",
    'color': Colors.redAccent.shade400
  },
  {
    'course_id': 1012,
    'course_name': "Kite Production",
    'description': "   “ The Kite Production course is designed for anyone interested in learning how to produce high-quality kites."
        "In this course, you will learn how to design and build kites, from the simplest single-line kites to more complex stunt kites."
        "You will also learn how to choose the right materials, sew and cut fabric, assemble the frame, and test and adjust the finished kite for optimal performance."
        "By the end of the course, you will have the skills and knowledge necessary to produce a variety of kites and create your own designs.",
    'course_content': [
      "Introduction to kite production: In this module, you will learn about the different types of kites, their history, and the materials used in kite production.",
      "Kite design: In this module, you will learn how to design kites, including choosing the right shape, size, and materials for your kite.",
      "Fabric selection and cutting: In this module, you will learn how to select the right fabric for your kite, as well as how to cut and sew the fabric to create the kite body.",
      "Frame assembly: In this module, you will learn how to assemble the frame of your kite, including choosing the right materials and constructing the frame.",
      "Bridle and line attachment: In this module, you will learn how to attach the bridle and lines to your kite to ensure proper flight.",
      "Testing and adjustment: In this module, you will learn how to test your finished kite and make adjustments to ensure optimal flight performance.",
    ],
    'perks': [
      "Skills and knowledge: You will learn how to design and build high-quality kites from scratch, giving you a unique skill set and a new hobby.",
      "Creativity: You will have the opportunity to design and create your own kite designs, giving you an outlet for creativity and self-expression.",
      "Personal satisfaction: Producing a kite from scratch can be a rewarding experience, and you will have the satisfaction of seeing your creation take to the skies.",
      "Career opportunities: The skills you learn in this course can lead to career opportunities in kite production, design, and manufacturing",
    ],
    'image_path': "Course_Images/Kite_Production.png",
    'color': Colors.redAccent.shade400
  },
  {
    'course_id': 1013,
    'course_name': "Shoe Designing",
    'description':
        "    This shoe designing course is designed to provide students with the knowledge and skills necessary to design and create their own shoes. The course will cover topics such as materials selection, shoe design principles, sketching and drawing techniques, prototyping and production, and branding and marketing.",
    'course_content': [
      "Introduction to Shoe Designing",
      "Materials and Selection",
      "Shoe Design Principles",
      "Prototyping and Production",
      "Branding and Marketing"
    ],
    'perks': [
      "Access to industry-standard shoe designing software",
      "Expert guidance and feedback from experienced shoe designers",
      "Opportunity to network with other aspiring designers",
      "Showcase your designs at fashion shows and exhibitions",
      "Certificate of completion at the end of the course."
    ],
    'image_path': "Course_Images/Shoe_Designing.png",
    'color': Colors.redAccent.shade400
  },
];

final feeds = [
  {
    'image_path': "assets/images/anurag.jpg",
    'location': "Kanpur, Uttar Pradesh",
    'description': "The workshop in Kanpur was executed successfully. People enjoyed learning and were eager to learn more. Also, they gave blessings to this wonderful program started by ImpactMe.",
    'timestamp': "23rd Mar, 2022 | 12:03PM",
    'user_name': "Anurag Tripathi",
    'user_image': "assets/images/anurag.jpg",
    'likes': 21,
    'comments': 5
  },
  {
    'image_path': "assets/images/anurag.jpg",
    'location': "Kanpur, Uttar Pradesh",
    'description': "The workshop in Kanpur was executed successfully. People enjoyed learning and were eager to learn more. Also, they gave blessings to this wonderful program started by ImpactMe.",
    'timestamp': "23rd Mar, 2022 | 12:03PM",
    'user_name': "Anurag Tripathi",
    'user_image': "assets/images/anurag.jpg",
    'likes': 21,
    'comments': 5
  },
  {
    'image_path': "assets/images/anurag.jpg",
    'location': "Kanpur, Uttar Pradesh",
    'description': "The workshop in Kanpur was executed successfully. People enjoyed learning and were eager to learn more. Also, they gave blessings to this wonderful program started by ImpactMe.",
    'timestamp': "23rd Mar, 2022 | 12:03PM",
    'user_name': "Anurag Tripathi",
    'user_image': "assets/images/anurag.jpg",
    'likes': 21,
    'comments': 5
  },
  {
    'image_path': "assets/images/anurag.jpg",
    'location': "Kanpur, Uttar Pradesh",
    'description': "The workshop in Kanpur was executed successfully. People enjoyed learning and were eager to learn more. Also, they gave blessings to this wonderful program started by ImpactMe.",
    'timestamp': "23rd Mar, 2022 | 12:03PM",
    'user_name': "Anurag Tripathi",
    'user_image': "assets/images/anurag.jpg",
    'likes': 21,
    'comments': 5
  }
];
