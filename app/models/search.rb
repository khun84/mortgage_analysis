module Search

    def self.search(project_title:nil, scenario_name:nil, irr:nil)
        Scenario.joins(:project).project_title(project_title).scenario_name(scenario_name).irr(irr)

    end

    def self.project_title(name)
        if name.present?
            where("projects.title ilike ?", "%#{name}%")
        else
            all
        end
    end

    def self.scenario_name(name)
        if name.present?
            where("scenarios.name ilike ?", "%#{name}%")
        else
            all
        end
    end

    def self.irr(irr)
        if irr.present?
            where("scenarios.irr >= ?", irr)
        else
            all
        end
    end


end