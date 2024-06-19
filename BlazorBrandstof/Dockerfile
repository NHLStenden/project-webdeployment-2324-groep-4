# V Begin met een basisafbeelding van .NET versie 8.0
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
# V Gebruik een specifieke gebruiker om de app te draaien
USER $APP_UID
# V Maak een map /app als werkmap
WORKDIR /app
# Maak poorten 8080 en 8081 open zodat de app bereikbaar is
EXPOSE 8080
EXPOSE 8081

# V Gebruik de .NET SDK versie 8.0 om de app te bouwen
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# V Zeg dat we de app willen bouwen in 'Release' modus (dus klaar voor gebruik)
ARG BUILD_CONFIGURATION=Release
# V Maak een map /src als werkmap
WORKDIR /src
# V Kopieer het projectbestand naar de map BlazorBrandstof in de cointainer
COPY ["BlazorBrandstof/BlazorBrandstof.csproj", "BlazorBrandstof/"]
# V Download de benodigde onderdelen (libraries) voor het project.
RUN dotnet restore "BlazorBrandstof/BlazorBrandstof.csproj"
# V Kopieer alle andere bestanden van ons project naar de container
COPY . .
# V Ga naar de map waar de projectcode staat
WORKDIR "/src/BlazorBrandstof"
# V Bouw de app met de 'Release' instelling en zet het resultaat in /app/build
RUN dotnet build "BlazorBrandstof.csproj" -c $BUILD_CONFIGURATION -o /app/build
# V Maak een nieuwe laag om de app klaar te maken voor gebruik
FROM build AS publish
# V Zeg opnieuw dat we de app willen publiceren in 'Release' modus
ARG BUILD_CONFIGURATION=Release
# V Publiceer (maak klaar) de app en zet het resultaat in /app/publish
# V /p:UseAppHost=false zorgt ervoor dat er geen speciale host gebruikt wordt
RUN dotnet publish "BlazorBrandstof.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false


# V Gebruik de basisafbeelding opnieuw voor uiteindelijke versie
FROM base AS final
# V Stel de werkmap weer in op /app
WORKDIR /app
# V Kopieer de gepubliceerde bestanden naar deze definitieve laag
COPY --from=publish /app/publish .
# V Zeg dat wanneer de container start, hetcommando 'dotnet BlazorBrandstof' moet worden uitgevoerd
ENTRYPOINT ["dotnet", "BlazorBrandstof.dll"]
