api: 

  name: student-app-api 

  repCount: 1 

  image: hungnguyen23/student-app-api:0.0.1-SNAPSHOT 

  port: 8080 

  targetPort: 8080 

  

client: 

  name: student-app-client 

  repCount: 1 

  image: hungnguyen23/student-app-client 

  port: 80 

  targetPort: 80 

  

volume: 

  name: mongo-pvc 

  storage: 256Mi 

mongo: 

  name: mongo 

  repCount: 1 

  image: mongo:3.6.17-xenial 

  port: 27017 

  targetPort: 27017 
