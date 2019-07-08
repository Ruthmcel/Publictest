#!groovy
pipeline {
	agent any
	parameters {
		string(name: 'tagName', description: 'The name of a tag that must exist in the pdx_dss_dev repo.')
		string(name: 'JiraVer', description: 'The name of the Jira release version.')
	}
	environment {
		EmailExcludes = "tcrosslin,ahoward"
		gitCmd = ''
	}
	tools {
		git 'Default'
	}
	stages {
		stage("Validate tag") {
			steps {				 
				git url: 'scmbuild@git:/srv/git/pdx_dss_dev.git'
				script {
					gitCmd = tool name: 'Default', type: 'git'
					sh "${gitCmd} checkout ${params.tagName}"              
					currentBuild.description = "${params.tagName}"
					currentBuild.displayName = "${params.tagName}.${env.BUILD_NUMBER}"
					def jenkinsAuditBuildDetails = new com.pdxinc.PDXJenkinsAuditBuildDetails()
					jenkinsAuditBuildDetails.updateJenkinsAuditBuildDetails("${currentBuild.displayName}")
					def jenkinsAuditChange = new com.pdxinc.PDXJenkinsAuditChangeLog()
					def DirList = ["${env.WORKSPACE}"] as String[]
					jenkinsAuditChange.updateJenkinsAuditChangeLog(DirList,"${currentBuild.displayName}")
				}
			}
		}
		stage("Deploy to Gold") {
			steps {
				echo "Deploying tag ${params.tagName} to Gold"
				sh "/opt/cmtools/bin/lookerPushTag.sh ${tagName} dev gold ${gitCmd}"
				script {
					def props = readProperties(file: '/opt/cmtools/PipelineProperties/LookerPipeline.properties')
					echo "Gold server is ${props.GoldLookerServer}"
					def res = sh  returnStdout: true, script: "curl https://"+props.GoldLookerServer+":9999/git/pull/pdx_dss"
					def match = sh  returnStatus: true, script: "echo $res | grep 'error:false'"
					assert match == 0, "Pull Failed in ${props.GoldLookerServer}"
					// Piece for unit testing the curl process for production in Gold Environment. Uncomment it when unit testing is required to test curl
					// def res2 = sh  returnStdout: true, script: "curl -k https://${props.Prod2LookerServer}/git/pull/pdx_dss"
					// def match2 = sh  returnStatus: true, script: "echo $res2 | grep 'error:false'"
					// assert match2 == 0, "Pull Failed in ${props.Prod2LookerServer} "
					def testBody = ""
					if ( env.TestDeploy == "true" ) {
						testBody = "<H1>This is a test deployment No action required</H1>"
					}
					def subject = "Pipeline Approval: Looker tag ${tagName} has been deployed to gold"
					def body = "<body>${testBody}<H3>Looker tag ${tagName} has been deployed to Gold (${props.GoldLookerServer}) </body>"
					emailext body: body, subject: subject, to: props.TagEmailList
					def subject2 = "Pipeline Approval: Looker tag ${tagName} is ready in gold for QA."
					def body2 = "<body>${testBody}<H3>Looker tag ${tagName} is now ready for QA testing and Approval in Gold</H3><p>Go to <a href='${env.BUILD_URL}/input'>${env.JOB_NAME} ${env.BUILD_NUMBER}</a> For QA Approval (${props.GoldLookerServer}) </body>"
					emailext body: body2, subject: subject2, to: props.QAEmailList
				}
				input message: 'QA Approval', ok: 'QA Approval', submitter: 'S-ROLE-CM-STAFF,kfroncek,cbarsode,sphatak,spanda'
			}
		}
		stage('QA Approved') {
			steps {
				script {
					def props = readProperties(file: '/opt/cmtools/PipelineProperties/LookerPipeline.properties')
					def subject = "Pipeline Approval: Looker tag '${tagName}' has been approved by QA and is now ready for production"
					def testBody = ""
					if ( env.TestDeploy == "true" ) {
						testBody = "<H1>This is a test deployment No action required</H1>"
					}
					def body = "<body>${testBody}<H3>Looker tag '${tagName}' is now ready for Production approval </H3><p>Go to <a href='${env.BUILD_URL}/input'>${env.JOB_NAME} ${env.BUILD_NUMBER}</a> For PO Approval</body>"
					emailext body: body, subject: subject, to: props.POEmailList		

				}
			}
		}
		stage('PO Approval') {
			steps {
				echo "Approval input moved to Deploy to prod"
			}
		}
		stage('Deploy to Prod') {
			steps {
				script {
					echo "Deploying ${tagName} to Production"
					def jenkinsAuditRelDetail = new com.pdxinc.PDXJenkinsAuditReleaseDetails()
					jenkinsAuditRelDetail.updateJenkinsAuditReleaseDetail("${currentBuild.displayName}","${currentBuild.displayName}")
					def testBody = ""
					if ( env.TestDeploy == "true" ) {
						testBody = "<H1>This is a test deployment No action required</H1>"
					}
					def ApprovalBody = "<body>${testBody}<H3>'${tagName}' is now ready for Production approval </H3><p>Go to <a href='${env.BUILD_URL}/input'>${env.JOB_NAME} ${env.BUILD_NUMBER}</a> For Prod Approval</body>"
					def ApprovalSubject = "Pipeline Approval: '${tagName}' has been approved by QA and is now ready for production"
					def jenkinsAuth = new com.pdxinc.PDXAuth()
					jenkinsAuth.getApproval("${tagName}.${env.BUILD_NUMBER}" , "S-ROLE-CM-STAFF,cnorth,jcfoss" , "${env.EmailExcludes}" , "${env.BUILD_NUMBER}" , "Prod")
					sh "/opt/cmtools/bin/lookerPushTag.sh ${tagName} gold prod ${gitCmd}"
					def Ver = JiraVer
					def props = readProperties(file: '/opt/cmtools/PipelineProperties/LookerPipeline.properties')
					def res = sh  returnStdout: true, script: "curl https://${props.Prod1LookerServer}:9999/git/pull/pdx_dss"
					def match = sh  returnStatus: true, script: "echo $res | grep 'error:false'"
					assert match == 0, "Pull Failed in ${props.Prod1LookerServer} "
					def res2 = sh  returnStdout: true, script: "curl -k https://${props.Prod2LookerServer}/git/pull/pdx_dss"
					def match2 = sh  returnStatus: true, script: "echo $res2 | grep 'error:false'"
					assert match2 == 0, "Pull Failed in ${props.Prod2LookerServer} "
					def subject = "Pipeline Approval: Looker tag '${tagName}' has been deployed to production"
					def body = "<body>${testBody}<H3>Looker tag '${tagName}' has been deployed to Production (${props.Prod1LookerServer},${props.Prod2LookerServer})</body>"
					emailext body: body, subject: subject, to: props.ProdEmailList
					def jenkinsAuditRelNote = new com.pdxinc.PDXJenkinsAuditReleaseNotes()
					jenkinsAuditRelNote.updateJenkinsAuditRelNote("${currentBuild.displayName}",'ERXLPS',"${Ver}")
				}
			}
		}
	}
	post {
		success {
			echo "Wow Build Passed"
			// script {
				// currentBuild.rawBuild.keepLog(true)
			// }
		}
		aborted {
			echo "Oops we had to abort"
			// script {
				// currentBuild.rawBuild.keepLog(true)
			// }
		}
		failure {
			echo "This sucks a failure"
			// script {
				// currentBuild.rawBuild.keepLog(true)
			// }
		}
		changed {
			echo "Not sure how it would get here."
		}
		unstable {
			echo "Just like me the build is unstable."
		}
	}
}