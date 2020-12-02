package com.streamster.videoservice.model.dto;

import com.streamster.videoservice.model.actions.ActionType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ActionDTO {
    @NotNull
    private ActionType actionType;
    @NotNull
    private String target;
}
