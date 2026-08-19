-- UselessPLStats database schema
-- Initial architecture

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS players (
    player_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    first_name TEXT,
    last_name TEXT,
    date_of_birth DATE,
    birth_city TEXT,
    birth_country TEXT,
    nationality TEXT,
    height_cm REAL,
    preferred_foot TEXT
);

CREATE TABLE IF NOT EXISTS teams (
    team_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    city TEXT,
    country TEXT,
    stadium TEXT,
    stadium_capacity INTEGER,
    latitude REAL,
    longitude REAL,
    founded_year INTEGER
);

CREATE TABLE IF NOT EXISTS seasons (
    season_id TEXT PRIMARY KEY,
    competition TEXT NOT NULL,
    season_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS matches (
    match_id TEXT PRIMARY KEY,
    season_id TEXT,
    date DATE,
    home_team_id TEXT,
    away_team_id TEXT,
    home_score INTEGER,
    away_score INTEGER,
    home_xg REAL,
    away_xg REAL,
    home_possession REAL,
    away_possession REAL,
    FOREIGN KEY (season_id) REFERENCES seasons(season_id),
    FOREIGN KEY (home_team_id) REFERENCES teams(team_id),
    FOREIGN KEY (away_team_id) REFERENCES teams(team_id)
);

CREATE TABLE IF NOT EXISTS player_match_stats (
    match_id TEXT,
    player_id TEXT,
    team_id TEXT,
    minutes INTEGER,
    goals INTEGER DEFAULT 0,
    assists INTEGER DEFAULT 0,
    shots INTEGER,
    shots_on_target INTEGER,
    xg REAL,
    xa REAL,
    passes INTEGER,
    tackles INTEGER,
    interceptions INTEGER,
    clearances INTEGER,
    fouls INTEGER,
    yellow_cards INTEGER,
    red_cards INTEGER,
    PRIMARY KEY (match_id, player_id),
    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE IF NOT EXISTS match_events (
    event_id TEXT PRIMARY KEY,
    match_id TEXT,
    minute INTEGER,
    second INTEGER,
    event_type TEXT,
    team_id TEXT,
    player_id TEXT,
    related_player_id TEXT,
    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id),
    FOREIGN KEY (player_id) REFERENCES players(player_id)
);

CREATE TABLE IF NOT EXISTS places (
    place_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    country TEXT,
    latitude REAL,
    longitude REAL,
    population INTEGER,
    population_density REAL,
    elevation_m REAL,
    distance_to_coast_km REAL
);

CREATE TABLE IF NOT EXISTS player_places (
    player_id TEXT PRIMARY KEY,
    place_id TEXT,
    FOREIGN KEY (player_id) REFERENCES players(player_id),
    FOREIGN KEY (place_id) REFERENCES places(place_id)
);

CREATE TABLE IF NOT EXISTS external_data (
    data_id TEXT PRIMARY KEY,
    place_id TEXT,
    category TEXT,
    variable TEXT,
    value REAL,
    unit TEXT,
    source TEXT,
    source_date DATE,
    FOREIGN KEY (place_id) REFERENCES places(place_id)
);
