module Search

    def self.search(project_name:nil, scenario_name:nil, irr:nil)
        Scenario.joins(:project).project_name(project_name).scenario_name(scenario_name).irr(irr)

    end

    def self.project_name(name)
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