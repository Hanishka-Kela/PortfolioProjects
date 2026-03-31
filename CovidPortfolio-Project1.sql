/*
Covid 19 Data Exploration 
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Views
*/

-- Basic Data
SELECT *
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4;


-- Starting Data
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2;


-- Total Cases vs Total Deaths
SELECT location, date, total_cases, total_deaths,
       (total_deaths * 100.0 / total_cases) AS DeathPercentage
FROM CovidDeaths
WHERE location LIKE '%states%'
AND continent IS NOT NULL
ORDER BY 1,2;


-- Total Cases vs Population
SELECT location, date, population, total_cases,
       (total_cases * 100.0 / population) AS PercentPopulationInfected
FROM CovidDeaths
ORDER BY 1,2;


-- Countries with Highest Infection Rate
SELECT location, population,
       MAX(total_cases) AS HighestInfectionCount,
       (MAX(total_cases) * 100.0 / population) AS PercentPopulationInfected
FROM CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;


-- Countries with Highest Death Count
SELECT location,
       MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;


-- Continent Death Count
SELECT continent,
       MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;


-- Global Numbers
SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    (SUM(new_deaths) * 100.0 / SUM(new_cases)) AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL;

SELECT COUNT(*) 
FROM CovidVaccinations
WHERE new_vaccinations IS NOT NULL;

-- Population vs Vaccinations (Rolling)
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) 
        OVER (PARTITION BY dea.location ORDER BY dea.date) 
        AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3;


-- CTE Version
WITH PopvsVac AS (
    SELECT 
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        vac.new_vaccinations,
        SUM(vac.new_vaccinations) 
            OVER (PARTITION BY dea.location ORDER BY dea.date) 
            AS RollingPeopleVaccinated
    FROM CovidDeaths dea
    JOIN CovidVaccinations vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT *,
       (RollingPeopleVaccinated * 100.0 / population) AS PercentVaccinated
FROM PopvsVac;


-- TEMP TABLE
DROP TEMPORARY TABLE IF EXISTS PercentPopulationVaccinated;

CREATE TEMPORARY TABLE PercentPopulationVaccinated (
    continent VARCHAR(255),
    location VARCHAR(255),
    date DATE,
    population DOUBLE,
    new_vaccinations DOUBLE,
    RollingPeopleVaccinated DOUBLE
);

INSERT INTO PercentPopulationVaccinated
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) 
        OVER (PARTITION BY dea.location ORDER BY dea.date)
FROM CovidDeaths dea
JOIN CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date;

SELECT *,
       (RollingPeopleVaccinated * 100.0 / population) AS PercentVaccinated
FROM PercentPopulationVaccinated;


-- VIEW
CREATE VIEW PercentPopulationVaccinatedView AS
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) 
        OVER (PARTITION BY dea.location ORDER BY dea.date)
        AS RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;