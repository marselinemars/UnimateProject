Map<String, List<String>> input = const {
  "email": ["Email ", "invalid email"],
  "password": [
    "Password ",
    '''
Password must:
- Be at least 8 characters long
- Include uppercase and lowercase letters
- Include numbers
- Include special characters
- Avoid common words or patterns
'''
  ],
  "confirm": ["Confirm Password", "Does not match Password "],
  "code": ["Type Verification Code ", "invalid Code "]
};

final List<Map<String, String>> universityInfoSections = [
  {
    "title": "University Name",
    "desc": "Enter the official name of the university.",
  },
  {
    "title": "Location",
    "desc": "Specify the city and country of the university.",
  },
  {
    "title": "Facilities",
    "desc": "Describe key campus facilities.",
  },
  {
    "title": "Programs",
    "desc": "List academic programs offered.",
  },
  {
    "title": "Admissions",
    "desc": "Provide admission requirements.",
  },
  {
    "title": "Tuition & Fees",
    "desc": "Detail tuition costs and scholarships.",
  },
  {
    "title": "Accreditations",
    "desc": "Indicate educational accreditations.",
  },
  {
    "title": "Rankings",
    "desc": "Mention notable recognitions.",
  },
  {
    "title": "Faculty",
    "desc": "Introduce key faculty members.",
  },
  {
    "title": "Research",
    "desc": "Describe research opportunities.",
  },
  {
    "title": "Student Life",
    "desc": "Share insights into campus culture.",
  },
  {
    "title": "Housing",
    "desc": "Provide housing options.",
  },
  {
    "title": "Career Services",
    "desc": "Detail job placement services.",
  },
  {
    "title": "International Programs",
    "desc": "Highlight study abroad opportunities.",
  },
  {
    "title": "Community Engagement",
    "desc": "Describe local involvement.",
  },
  {
    "title": "Notable Alumni",
    "desc": "Mention successful graduates.",
  },
  {
    "title": "Athletics",
    "desc": "Detail sports programs.",
  },
  {
    "title": "Diversity & Inclusion",
    "desc": "Describe campus initiatives.",
  },
  {
    "title": "Safety",
    "desc": "Provide campus safety information.",
  },
  {
    "title": "Contact Info",
    "desc": "Include admissions contact details.",
  },
  {
    "title": "Online Presence",
    "desc": "Provide website and social media links.",
  },
];

List<Map<String, String>> specialtyInfoSections = [
  {
    "title": "Overview",
    "description": "Briefly describe the major and its core focus areas."
  },
  {
    "title": "Curriculum",
    "description": "List core courses, specializations, and electives."
  },
  {
    "title": "Degree Requirements",
    "description":
        "Specify the credit hours required and any capstone projects."
  },
  {
    "title": "Challenges and Opportunities",
    "description":
        "Highlight challenges and hands-on opportunities for students."
  },
  {
    "title": "Faculty",
    "description":
        "Provide profiles of key faculty members and their expertise."
  },
  {
    "title": "Research Opportunities",
    "description": "Indicate availability of research projects and centers."
  },
  {
    "title": "Practical Skills Development",
    "description": "Emphasize hands-on learning and practical skills."
  },
  {
    "title": "Career Pathways",
    "description": "Outline common career paths and job placement rates."
  },
  {
    "title": "Industry Connections",
    "description":
        "Describe relationships with industry partners and networking."
  },
  {
    "title": "Special Programs or Initiatives",
    "description": "Highlight unique programs or collaborations."
  },
  {
    "title": "Current Trends and Innovations",
    "description": "Discuss recent developments and integration of technology."
  },
  {
    "title": "Internship and Job Placement",
    "description":
        "Detail availability of internships and job placement services."
  },
  {
    "title": "Alumni Success",
    "description": "Showcase profiles of successful alumni."
  },
  {
    "title": "Skills and Competencies Developed",
    "description":
        "List specific skills and competencies students will acquire."
  },
  {
    "title": "Accreditations and Certifications",
    "description": "Specify accreditation status and associated certifications."
  },
  {
    "title": "Unique Features",
    "description": "Highlight distinctive aspects of the major."
  },
  {
    "title": "Admission Requirements",
    "description": "Outline prerequisites and academic criteria for admission."
  },
  {
    "title": "Class Sizes and Student-to-Faculty Ratio",
    "description": "Specify average class size and student-to-faculty ratio."
  },
  {
    "title": "Costs and Financial Aid",
    "description": "Detail tuition, fees, and available financial aid."
  },
  {
    "title": "Universities that Teach this Major",
    "description":
        "List universities or colleges known for offering this major. Provide options for users to add multiple institutions."
  },
  {
    "title": "Advice for Studying the Major",
    "description":
        "Offer advice or tips for students pursuing this major. Include insights from faculty or successful alumni."
  },
  {
    "title": "Additional Information",
    "description":
        "Allow for any additional information or details about the major. Provide an open-ended section for contributors."
  },
  {
    "title": "Programs and Subjects to Study",
    "description":
        "Outline specific programs and subjects within the major. Include details on unique courses or concentrations."
  },
];
