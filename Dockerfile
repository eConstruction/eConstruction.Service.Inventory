# This stage is used when running from VS in fast mode (Default for Debug configuration)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 7070

ENV ASPNETCORE_URLS=http://+:7070

# This stage is used to build the service project
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["src/eConstruction.Service.Inventory/eConstruction.Service.Inventory.csproj", "src/eConstruction.Service.Inventory/"]
RUN dotnet restore "./src/eConstruction.Service.Inventory/eConstruction.Service.Inventory.csproj"
COPY . .
WORKDIR "/src/src/eConstruction.Service.Inventory"
RUN dotnet build "./eConstruction.Service.Inventory.csproj" -c $BUILD_CONFIGURATION -o /app/build

# This stage is used to publish the service project to be copied to the final stage
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./eConstruction.Service.Inventory.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# This stage is used in production or when running from VS in regular mode (Default when not using the Debug configuration)
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "eConstruction.Service.Inventory.dll"]