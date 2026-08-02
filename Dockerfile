FROM mcr.microsoft.com/dotnet/runtime-deps:10.0.0-noble-chiseled
WORKDIR /app
COPY --from=builder ./cartservice ./cartservice/
EXPOSE 7070
USER 1000
ENTRYPOINT ["/app/cartservice/cartservice"]