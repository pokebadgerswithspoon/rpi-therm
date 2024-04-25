package com.icntfml.therm.app;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Map;
import java.util.stream.Collectors;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("")
public class TemperatureEndpoint {

    @ConfigProperty(name = "cache.file")
    File cache;
    @ConfigProperty(name = "cache.ttl")
    long cacheTtl = 1200;

    @GET
    @Path("cgi-bin/index.cgi")
    @Produces({MediaType.APPLICATION_JSON})
    public String getTemp() {
        try {
            if (!cache.exists()) {
                return error("File not found (%s)".formatted(cache));
            }
            long age = ( System.currentTimeMillis() - cache.lastModified())/1000;
            if (age > cacheTtl) {
                return error("Stale");
            }
            return Files.readString(cache.toPath());
        } catch (IOException e) {
            return error(e.getMessage());
        }
    }

    @POST
    @Path("temperature")
    public String postTemp(String payload) {
        try {
            Files.writeString(cache.toPath(), payload);
            return ok();
        } catch (Exception ex) {
            ex.printStackTrace();
            return error(ex.getMessage());
        }
    }

    String ok() {
        return toJsonString(Map.of("ok", true));
    }
    String error(String message) {
        return toJsonString(Map.of("error", message));
    }

    String toJsonString(Map<String, Object> keys) {
        return keys.entrySet()
            .stream()
            .map(entry -> "\"%s\": \"%s\"".formatted(entry.getKey(), entry.getValue()))
            .collect(Collectors.joining(
                ",",
                "{ ",
                " }"
            ));
    }

}
