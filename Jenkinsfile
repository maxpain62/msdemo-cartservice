podTemplate(yaml: readTrusted('pod.yaml')) {
    node(POD_LABEL) {
        stage('Checkout') {
            git branch: 'main', url: 'https://github.com/maxpain62/msdemo-cartservice.git'
        }
        stage('build') {
            container('dotnet-build') {
                sh '''
                dotnet restore ./src/cartservice.csproj -a amd64
                dotnet publish src/cartservice.csproj -p:PublishSingleFile=true -a amd64 --self-contained true -p:PublishTrimmed=true -p:TrimMode=full -c release -o ./cartservice
                '''
            }
        }
        stage('Build Docker Image') {
            container('buildkit') {
                sh """
                    buildctl --addr tcp://buildkitd.devops-tools.svc.cluster.local:1234\
                    --tlscacert /certs/ca.pem\
                    --tlscert /certs/cert.pem\
                    --tlskey /certs/key.pem\
                    build --frontend dockerfile.v0\
                    --opt filename=Dockerfile --local context=.\
                    --local dockerfile=.\
                    --output type=image,name=134448505602.dkr.ecr.ap-south-1.amazonaws.com/msdemo-cartservice,push=true
                """
            }
        }
    }
}