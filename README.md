# .NET Project Jenkins Pipeline

## Required Jenkins plugins

- Docker Pipeline (Version572.v950f58993843 is tested)

## Instructions

1. Download Jenkins war file and start Jenkins server
	```
	./run_jenkins.sh
	./run_jenkins.sh
	```
2. [Open Jenkins in browser](http://localhost:8080/)
3. Install the required plugins
4. Create a new `Pipeline` job
5. Copy the content of [Jenkinsfile](./Jenkinsfile) to the Pipeline script
6. Save the job
7. Run the job
8. Check the test results in the job page

## Conlusion

The error `System.UnauthorizedAccessException: Access to the path '/.dotnet' is denied.` was the most challenging part, I solved it by using `root` user in the docker container.

The task requirement states that `if the tests executed successfully without failures, then the solution should
be published`. I think it is better to publish the artifact even if the test fails, so that the artifact can be used for further investigation. This can be achieved by adding a `post` stage to publish the artifact, or adding `catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {}` wrapper to the test stages. In case that one test stage failure causes that the `Publish` stage is skipped.

There is also another jenkins plugin [MSTest](https://plugins.jenkins.io/mstest/) available to convert MSTest TRX test reports into JUnit XML reports so it can be integrated with Jenkin's JUnit features. But seems it is not required for this task, so it is not used.

I have learned how to run stages in parallel and dotnet build, test and publish commands.

Roughly, 2 - 3 hours was spent on this task to explore the .net docker container, and write, test, refine the pipeline.

