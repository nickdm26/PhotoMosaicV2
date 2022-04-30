#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY "PhotoMosaicV2" "PhotoMosaicV2"
COPY "PhotoMosaicV2.Tests" "PhotoMosaicV2.Tests"
RUN dotnet restore "./PhotoMosaicV2/PhotoMosaicV2.csproj"
RUN dotnet restore "./PhotoMosaicV2.Tests/PhotoMosaicV2.Tests.csproj"


WORKDIR "/src/."
RUN dotnet build "PhotoMosaicV2/PhotoMosaicV2.csproj" -c Release -o /app/build
RUN dotnet build "PhotoMosaicV2.Tests/PhotoMosaicV2.Tests.csproj" -c Release -o /app/build

FROM build AS test
LABEL test=true
#RUN dotnet test --no-build -c Release --results-directory /testresults --logger "trx;LogFileName=test_results.trx" "PhotoMosaicV2.Tests/PhotoMosaicV2.Tests.csproj"
#ENTRYPOINT [ "dotnet", "test", "PhotoMosaicV2.Tests/PhotoMosaicV2.Tests.csproj", "--logger", "trx;LogFileName=test_results.trx" ]
RUN dotnet test "PhotoMosaicV2.Tests/PhotoMosaicV2.Tests.csproj" --logger "trx;LogFileName=test_results.trx"

FROM build AS publish
RUN dotnet publish "PhotoMosaicV2/PhotoMosaicV2.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "PhotoMosaicV2.dll"]